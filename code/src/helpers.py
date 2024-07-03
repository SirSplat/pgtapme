import argparse
import inspect
import logging
import os
from functools import wraps

import psycopg2
from dotenv import load_dotenv


def parse_command_line_args():
    logging.debug("Parsing command-lins arguments.")

    """
    Parse command-line arguments for logging and module type configuration.

    Returns:
        argparse.Namespace: Parsed command-line arguments.
    """
    parser = argparse.ArgumentParser(description="Your script description")
    parser.add_argument(
        "--log-level",
        dest="log_level",
        default="WARNING",
        choices=["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"],
        help="Set the logging level (DEBUG, INFO, WARNING, ERROR, CRITICAL)",
    )
    parser.add_argument(
        "--module-type", dest="module_type", default=None, help="Override module types"
    )
    # New arguments for database connection
    parser.add_argument(
        "--db-name", dest="database_name", default=None, help="Override database name"
    )
    parser.add_argument(
        "--db-user", dest="database_user", default=None, help="Override database user"
    )
    parser.add_argument(
        "--db-password",
        dest="database_user_password",
        default=None,
        help="Override database user password",
    )
    parser.add_argument(
        "--db-host", dest="database_host", default=None, help="Override database host"
    )
    parser.add_argument(
        "--db-port", dest="database_port", default=None, help="Override database port"
    )
    args = parser.parse_args()

    logging.debug(f"Command-line arguments parsed: {args}")

    return args


def override_module_type(config, module_type):
    logging.debug(f"Overriding module types with: {module_type}")

    """
    Override the 'module_types' in the given configuration if a test type is provided.

    Args:
        config (dict): The configuration dictionary.
        module_type (str or None): The test type to override with, or None if not provided.
    """
    if module_type:
        config["module_types"] = [module_type]
        logging.debug(f"Module types overridden: {config['module_types']}")
    else:
        logging.debug("No module type overide provided.")


def get_modules(config):
    logging.debug("Retrieving module types from configuration.")

    """
    Get the module types from command-line arguments and configuration.

    Args:
        config (dict): The configuration dictionary.

    Returns:
        list: A list of module types.
    """
    args = parse_command_line_args()
    configure_logging_from_args(args)
    override_module_type(config, args.module_type)
    modules = config.get("module_types", [])

    logging.debug(f"Modules to process: {modules}")

    return modules


def configure_logging():
    logging.debug("Configuring logging.")

    args = parse_command_line_args()

    # Configure logging based on the command line argument if provided.
    # If --log-level argument is not provided, keep the default level as WARNING.
    configure_logging_from_args(args)

    logging.debug(f"Logging configured with level: {args.log_level}")


def configure_logging_from_args(args):
    logging.debug("Configuring logging from command-line arguments.")

    """
    Configure logging based on the command line argument if provided.
    If --log-level argument is not provided, keep the default level as WARNING.
    """
    # Get the root logger
    root_logger = logging.getLogger()

    # Check if --log-level argument is provided
    if hasattr(args, "log_level") and args.log_level:
        # Set the logging level for the root logger
        root_logger.setLevel(getattr(logging, args.log_level))

        logging.debug(f"Logging level set to: {args.log_level}")
    else:
        # Use the default logging configuration
        logging.basicConfig(
            level=logging.WARNING,
            format="%(asctime)s %(levelname)s : %(message)s",
            datefmt="%Y-%m-%d %H:%M:%S",
        )

        logging.debug("Default logging configuration applied with level: WARNING")


def log_function_call(func=None, log_level=logging.DEBUG, info_message=None):
    logging.debug("Initializing log_function_call decorator.")

    """
    A versatile decorator that logs function calls, including parameter names and values,
    at a specified log level (default: logging.DEBUG). It also logs additional
    information at the INFO level if provided.

    Parameters:
    - func: The function to be decorated. If used without specifying other parameters,
      it returns the decorator itself.
    - log_level: The log level for function call details (default: logging.DEBUG).
    - info_message: Additional information to be logged at the INFO level.

    Usage:
    1. Basic usage (DEBUG level):
        @log_function_call
        def my_function(arg1, arg2):
            # Function body
    Example Output Line:
    DEBUG: Inside module.my_function: arg1='value1' arg2='value2'

    2. Specify log level and provide additional info (INFO level):
        @log_function_call(log_level=logging.INFO, info_message="Custom info")
        def another_function(arg1, arg2):
            # Function body
    Example Output Line:
    INFO: Custom info module.another_function: arg1='value1' arg2='value2'

    3. Specify only the log level (WARNING level):
        @log_function_call(log_level=logging.WARNING)
        def third_function(arg1, arg2):
            # Function body
    Example Output Line:
    WARNING: Inside module.third_function: arg1='value1' arg2='value2'

    4. Specify only the additional info (DEBUG level for function details, INFO level for additional info):
        @log_function_call(info_message="Detailed information")
        def fourth_function(arg1, arg2):
            # Function body
    Example Output Line:
    DEBUG: Inside module.fourth_function: arg1='value1' arg2='value2'
    INFO: Detailed information module.fourth_function

    5. Use as a decorator factory (INFO level for function details, INFO level for additional info):
        log_fancy = log_function_call(log_level=logging.INFO, info_message="Fancy details")
        @log_fancy
        def fancy_function(arg1, arg2):
            # Function body
    Example Output Line:
    INFO: Inside module.fancy_function: arg1='value1' arg2='value2'
    INFO: Fancy details module.fancy_function
    """

    def decorator(func):
        logging.debug(f"Decorating function: {func.__name__}")

        @wraps(func)
        def wrapper(*args, **kwargs):
            func_name = func.__name__

            # Get the names of the function parameters
            signature = inspect.signature(func)
            param_names = [param.name for param in signature.parameters.values()]

            # Log the parameter names and values at the specified log level
            arg_values = ", ".join(
                f"{arg}={repr(value)}" for arg, value in zip(param_names, args)
            )
            kwarg_values = ", ".join(
                f"{key}={repr(value)}" for key, value in kwargs.items()
            )
            logging.log(
                log_level,
                f"Inside {func.__module__}.{func_name}: {arg_values} {kwarg_values}",
            )

            # Log additional info at INFO level if provided
            if info_message:
                logging.info(f"{info_message} {func.__module__}.{func_name}")

            # Execute the function and log the return value
            result = func(*args, **kwargs)

            logging.log(log_level, f"{func.__module__}.{func_name} returned: {result}")

            return result

        return wrapper

    # Check if the decorator is used without specifying a log level
    if func is None:
        return decorator
    else:
        return decorator(func)


@log_function_call
def create_file_path(output_dir, *parts):
    odir = os.path.join(output_dir, *parts[:-1])

    if not os.path.exists(odir):
        os.makedirs(odir)

        logging.debug(f"Created directory: {odir}")

    try:
        file_path = os.path.join(odir, f"{parts[-1]}.sql")

        logging.debug(f"Created file path: {file_path}")

        return file_path
    except Exception as e:
        logging.error(f"Failed to create file path: {e}")

        raise


@log_function_call
def replace_test_count(file_path, test_count):
    try:
        logging.debug(f"Reading file: {file_path}")

        with open(file_path, "r") as f:
            content = f.read()

        logging.debug(f"Replacing test count in file: {file_path}")

        content = content.replace(f"(0)", f"({test_count})")

        logging.debug(f"Writing updated content to file: {file_path}")

        with open(file_path, "w") as f:
            f.write(content)

        logging.debug(f"Successfully replaced test count in file: {file_path}")
    except Exception as e:
        logging.error(f"Failed to replace test count in file {file_path}: {e}")

        raise


@log_function_call
def count_tests_in_file(file_path):
    word = "SELECT"
    count = 0
    try:
        logging.debug(f"Counting occurrences of '{word}' in file: {file_path}")

        with open(file_path, "r") as f:
            for line in f:
                count += line.split().count(word)

        # Subtracting 2 to exclude the "SELECT plan(?);" and "SELECT * FROM finish();"
        test_count = count - 2

        logging.debug(
            f"Total test count in file (excluding plan and finish): {test_count}"
        )
        return test_count
    except Exception as e:
        logging.error(f"Failed to count tests in file {file_path}: {e}")
        raise


@log_function_call
def set_plan_count(test_file_path):
    try:
        logging.debug(f"Setting plan count for test file: {test_file_path}")
        test_count = count_tests_in_file(test_file_path)
        logging.debug(f"Test count determined: {test_count}")
        replace_test_count(test_file_path, test_count)
        logging.debug(f"Plan count set successfully for test file: {test_file_path}")
    except Exception as e:
        logging.error(f"Failed to set plan count for test file {test_file_path}: {e}")
        raise


@log_function_call
def connect_to_database():
    load_dotenv()
    args = parse_command_line_args()

    # Use command-line arguments if provided, otherwise fall back to .env variables
    database_name = args.database_name or os.getenv("DATABASE_NAME")
    database_user = args.database_user or os.getenv("DATABASE_USER")
    database_user_password = args.database_user_password or os.getenv(
        "DATABASE_USER_PASSWORD"
    )
    database_host = args.database_host or os.getenv("DATABASE_HOST")
    database_port = args.database_port or os.getenv("DATABASE_PORT")

    # Check if all necessary parameters are provided
    if not all(
        [
            database_name,
            database_user,
            database_user_password,
            database_host,
            database_port,
        ]
    ):
        logging.error("Missing one or more required database connection parameters.")
        raise ValueError("Missing one or more required database connection parameters.")

    try:
        conn = psycopg2.connect(
            database=database_name,
            user=database_user,
            password=database_user_password,
            host=database_host,
            port=database_port,
        )
        logging.debug(
            f"Connected to database: {database_name} at {database_host}:{database_port}"
        )
        return conn, database_name
    except psycopg2.DatabaseError as e:
        logging.error(f"Database connection failed: {e}")
        raise
    except Exception as e:
        logging.error(
            f"An unexpected error occurred while connecting to the database: {e}",
            exc_info=True,
        )
        raise


@log_function_call()
def format_array_parameter(parameter):
    logging.debug(f"Formatting parameter: {parameter}")
    """
    Formats a list of parameters into a PostgreSQL array string.

    Args:
        parameter_list (list or tuple): The list of parameters to be formatted.

    Returns:
        str: The formatted PostgreSQL array string.

    Examples:
        >>> format_array_parameter(['param1', 'param2'])
        # Outputs: "ARRAY['param1', 'param2']::TEXT[]"

        >>> format_array_parameter([])
        # Outputs: "ARRAY[]::TEXT[]"
    """
    if parameter is None:
        result = "ARRAY[]::TEXT[]"
    elif isinstance(parameter, (list, tuple)):
        result = f"ARRAY{parameter}::TEXT[]"
    elif isinstance(parameter, (str)):
        result = f"ARRAY['{parameter}']::TEXT[]"
    else:
        logging.error("Parameter must be a list, tuple, or string")
        raise TypeError("Parameter must be a list or tuple")

    logging.debug(f"Formatted parameter: {result}")
    return result


@log_function_call
def format_directory_element(parameter):
    logging.debug(f"Formatting directory element: {parameter}")
    """
    Removes double quotes and replaces spaces with underscores because I do not
        like them in directory and file names

    Args:
        parameter (str): The parameter to be formatted.

    Returns:
        str: The formatted directory element.

    Raises:
        TypeError: If the parameter is not a string.

    Examples:
        >>> format_directory_element('"my file"')
        'my_file'
    """
    if isinstance(parameter, str):
        result = parameter.strip('"').replace(" ", "_")
    else:
        logging.error("Parameter must be a string")
        raise TypeError("Parameter must be a string")

    logging.debug(f"Formatted directory element: {result}")
    return result


@log_function_call
def format_single_quote(parameter):
    logging.debug(f"Formatting single quote for parameter: {parameter}")
    """
    Have been forced to hard code for certain column defaults! not ideal, I know!

    Maybe someday I can find a much better solution than this.
    """
    if isinstance(parameter, str):
        if "'" in parameter:
            if "nextval" in parameter or "now" in parameter:
                result = f"$${parameter}$$"
            else:
                result = parameter
        else:
            result = f"'{parameter}'"
        logging.debug(f"Formatted single quote parameter: {result}")
        return result
    else:
        logging.error("Parameter must be a string")
        raise TypeError("Parameter must be a string")


@log_function_call
def remove_schema(parameter):
    logging.debug(f"Removing schema from parameter: {parameter}")
    if "." in parameter and parameter is not None:
        split_parts = parameter.split(".")
        result = split_parts[-1]
        logging.debug(f"Schema removed, result: {result}")
        return result
    logging.debug(f"No schema to remove, result: {parameter}")
    return parameter


@log_function_call
def validate_kinds(reltype, kinds=None):
    logging.debug(f"Validating kinds for reltype: {reltype}, kinds: {kinds}")
    """
    Validates a list of relation kinds against a predefined set of permissible values for a specific relation type.

    Parameters:
        reltype (str): The type of relation for which to validate the relkinds.
        kinds (list): A list of relation kinds to be validated.

    Raises:
        ValueError: If the provided reltype is not found in the predefined mappings.
                    If any relkinds are not present in the set of valid relkinds for the specified reltype.

    Example:
        # Example usage for validating relation kinds for pg_class
        valid_mappings = {
            'pg_class': {'a': 'Description for a', 'b': 'Description for b', 'c': 'Description for c'},
            # Add more mappings as needed
        }
        kinds = ['a', 'b', 'x']

        try:
            validate_relkinds('pg_class', relkinds)
            print("Validation successful!")
        except ValueError as e:
            print(f"Validation failed: {str(e)}")

    """
    valid_mappings = {
        "pg_class": {
            "c": "composite type",
            "f": "foreign table",
            "i": "index",
            "I": "partitioned index",
            "m": "materialized view",
            "p": "partitioned table",
            "r": "ordinary table",
            "S": "sequence",
            "t": "TOAST table",
            "v": "view",
        },
        "pg_proc": {
            "a": "aggregate",
            "f": "normal function",
            "p": "procedure",
            "w": "window function",
        },
        "pg_type": {
            "b": "base",
            "c": "composite",
            "d": "domain",
            "e": "enum",
            "p": "pseudo",
            "r": "range",
            "M": "multirange",
        },
    }

    valid_kinds = valid_mappings.get(reltype)
    if valid_kinds is None:
        logging.error(
            f"Invalid reltype: {reltype}. Valid reltypes are: {list(valid_mappings.keys())}"
        )
        raise ValueError(
            f"Invalid reltype: {reltype}. Valid reltypes are: {list(valid_mappings.keys())}"
        )

    if not kinds:
        logging.error(
            f"Invalid kinds must not be empty for reltype '{reltype}'. Valid kinds are: {list(valid_kinds.keys())}"
        )
        raise ValueError(
            f"Invalid kinds must not be empty for reltype '{reltype}'. Valid kinds are: {list(valid_kinds.keys())}"
        )

    invalid_kinds = [k for k in kinds if k not in valid_kinds]
    if invalid_kinds:
        invalid_str = ", ".join(invalid_kinds)
        logging.error(
            f"Invalid kind value(s) for reltype '{reltype}': {invalid_str}. Permissible values are: {list(valid_kinds.keys())}"
        )
        raise ValueError(
            f"Invalid kind value(s) for reltype '{reltype}': {invalid_str}. Permissible values are: {list(valid_kinds.keys())}"
        )

    logging.debug(f"Validation successful for reltype: {reltype}, kinds: {kinds}")
