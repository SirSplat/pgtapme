import re
import requests
from bs4 import BeautifulSoup

current_pgtap_version = "pgTAP 1.3.2"
categories = [
    "iobject",
    # "tohaveorhavenot",
    # "tableforone",
    # "feelingfunky",
    # "databasedeets",
    # "whoownsme",
    # "privilegedaccess",
]
donot_want_categories = [
    "contents",
    "synopsis",
    "installation",
    "pgtaptestscripts",
    "usingpgtap",
    "pursuingyourquery",
    "notestforthewicked",
    "secretsofthepgtapmavens",
    "composeyourself",
    "compatibility",
    "metadata",
]

url = "https://pgtap.org/documentation.html"
current_pgtap_version_id = str(current_pgtap_version).replace(" ", "").lower()
page = requests.get(url)
soup = BeautifulSoup(page.content, "html.parser")

if not page.ok:
    raise Exception(f"Failed to fetch web page: {page.status_code}")  # Stop the program

# Ensure PGTap version is not already being used.
h1_tags = soup.find_all("h1")

for h1_tag in h1_tags:
    if h1_tag.get("id") in donot_want_categories or h1_tag.get("id") is None:
        continue

    if h1_tag.get("id") == current_pgtap_version_id:
        print("PGTap version already used:", h1_tag.text)
        break
    else:
        if "pgTAP" in h1_tag.text:
            print(
                f"New version found ({h1_tag.text}) current version ({current_pgtap_version})"
            )
            continue

    root = h1_tag.get("id")

print(f"Root: {root}")

# Get all h2 tags after the root
h2_tags = soup.find("h1", {"id": root}).find_next_siblings("h2")

for h2_tag in h2_tags:
    if h2_tag.get("id") not in categories or h2_tag.get("id") is None:
        continue

    print(
        f"Processing category: {h2_tag.text.replace(' ', '') if h2_tag.text else 'None'}"
    )

    # Get all h3 tags after the h2 tag
    h3_tags = h2_tag.find_next_siblings("h3")

    for h3_tag in h3_tags:
        prev_h2 = h3_tag.find_previous("h2")

        if prev_h2.get("id") != h2_tag.get("id"):
            break

        print(
            f"Processing group: {h3_tag.get('id')} : {h3_tag.text.replace(' ', '') if h3_tag.text else 'None'} : href: #{h3_tag.get('id')}"
        )

        # Get the h3 tag code block for the current h3_tag.get('id')
        pre_tag = h3_tag.find_next("pre")
        if pre_tag is None:
            print(f"Code not found!")
            continue

        # Get the dl tag that is a sibling of the h3 tag
        dl_tag = h3_tag.find_next_sibling("dl")
        if dl_tag is None:
            print(f"dl tag not found!")
            continue

        # Extract the parameters and their descriptions
        parameters = {}
        data_types = {}
        for dt, dd in zip(dl_tag.find_all("dt"), dl_tag.find_all("dd")):
            parameter = dt.text.strip()
            description = dd.text.strip()

            # Determine the data type based on the description
            if 'array' in description:
                data_type = 'NAME[]'
            elif 'description' in description:
                data_type = 'TEXT'
            else:
                data_type = 'NAME'  # Default data type

            # Remove the colon from the parameter name before using it as a key
            data_types[parameter[1:]] = data_type

            if "array" in description:
                replacement = parameter[1:] + "[]"
            elif parameter == ":description":
                replacement = "description"
            else:
                replacement = parameter[1:]

            parameters[":" + parameter[1:]] = (
                replacement  # Include the colon in the key
            )

        print(f"DEBUG: Data types: {data_types}")

        # Extract the SQL statements and replace the placeholders
        replaced_code = []
        for code in pre_tag.stripped_strings:
            for placeholder, replacement in parameters.items():
                code = re.sub(re.escape(placeholder), replacement, code)
            replaced_code.append(code)

        replaced_code = "\n".join(replaced_code)

        # Split the replaced_code by semicolon to get individual SQL statements
        sql_statements = replaced_code.split(";")

        for sql_statement in sql_statements:
            # Ignore empty statements
            if not sql_statement.strip():
                continue

            # Extract the function name and parameters from the code
            match = re.match(r"SELECT\s+(\w+)\s*\((.*)\)", sql_statement.strip())

            if not match:
                print(f"Match not made! {sql_statement.strip()}")
                continue

            function_name = match.group(1)
            parameters = match.group(2)

            print(f"DEBUG: MATCH.group[1]: {function_name}")
            print(f"DEBUG: MATCH.group[2]: {parameters}")
            
            # Replace the parameter names with their data types
            parameters = parameters.split(",")
            for i, parameter in enumerate(parameters):
                parameter = parameter.strip().replace("[]", "")
                # print(f"DEBUG: i: {i} : Parameter: {parameter}")
                if parameter in data_types:  # Check if the parameter is in data_types
                    parameters[i] = data_types[parameter]  # Replace the parameter with its data type

            # Join the function name and parameters with hyphens to form the filename
            filename = f"{function_name}-{'-'.join(parameters)}.sql"

            # Print the filename
            print(f"Filename: {filename} : SQL : {sql_statement.strip()}")

        print("\n")
