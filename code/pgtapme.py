import json
import logging
import os
from importlib import import_module

from psycopg2 import extras

from src.helpers import configure_logging, connect_to_database, get_modules


def main() -> None:
    configure_logging()

    """
    It appears these two lines are required to prevent:
        output_dir = config['output_dir']
                 ~~~~~~^^^^^^^^^^^^^^
        KeyError: 'output_dir'

    When executing pgtapme.py from outside the package directory.
    """
    script_directory = os.path.dirname(os.path.realpath(__file__))
    config_path = os.path.join(script_directory, "config.json")

    try:
        with open(config_path, "r") as config_file:
            config = json.load(config_file)
    except FileNotFoundError as e:
        logging.error(f"Error: config.json file not found. {e}")
        return
    except json.JSONDecodeError as e:
        logging.error(f"Error: decoding config.json. {e}")
        return
    except KeyError as e:
        logging.error(f"Error: missing or unfound config key. {e}")
    except Exception as e:
        logging.error(f"An unexpected error occurred: {e}", exc_info=True)

    """
    This creates the output_dir 'pgtapme_generated_files_{database_name}' in the directory where pgtapme.py is executed
        from i.e. $(pwd)/pgtapme_generated_files_dvdrental
    """
    logging.info(
        "TODO: Figure out how to get the generated tests created where pgtapme.py was executed from!"
    )
    output_dir = os.path.join(config["output_dir"])
    conn = connect_to_database()
    cursor = conn.cursor(cursor_factory=extras.NamedTupleCursor)

    logging.debug("Reverse engineer schema started.")

    module_types = get_modules(config)

    for module_type in module_types:
        module = import_module(f"src.module_types.{module_type}", "t")
        process_data_function = getattr(module, "process_data", None)

        if process_data_function:
            process_data_function(cursor, output_dir, module_type)

    logging.debug("Reverse engineer schema completed.")

    cursor.close()
    conn.close()


if __name__ == "__main__":
    main()
