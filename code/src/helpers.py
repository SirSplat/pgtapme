import argparse
import inspect
import logging
import os
from functools import wraps

import psycopg2
from dotenv import load_dotenv


def parse_command_line_args():
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
    return parser.parse_args()


def override_module_type(config, module_type):
    """
    Override the 'module_types' in the given configuration if a test type is provided.

    Args:
        config (dict): The configuration dictionary.
        module_type (str or None): The test type to override with, or None if not provided.
    """
    if module_type:
        config["module_types"] = [module_type]


def get_modules(config):
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
    return config.get("module_types", [])


def configure_logging():
    args = parse_command_line_args()

    # Configure logging based on the command line argument if provided.
    # If --log-level argument is not provided, keep the default level as WARNING.
    configure_logging_from_args(args)


def configure_logging_from_args(args):
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
    else:
        # Use the default logging configuration
        logging.basicConfig(
            level=logging.WARNING,
            format="%(asctime)s %(levelname)s : %(message)s",
            datefmt="%Y-%m-%d %H:%M:%S",
        )


def log_function_call(func=None, log_level=logging.DEBUG, info_message=None):
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

            return func(*args, **kwargs)

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
        os.makedirs(odir, mode=0o755, exist_ok=False)
    return os.path.join(odir, f"{parts[-1]}.sql")


@log_function_call
def replace_test_count(file_path, test_count):
    with open(file_path, "r") as f:
        content = f.read()
    content = content.replace(f"(0)", f"({test_count})")
    with open(file_path, "w") as f:
        f.write(content)


@log_function_call
def count_tests_in_file(file_path):
    word = "SELECT"
    count = 0
    with open(file_path, "r") as f:
        for line in f:
            count += line.split().count(word)
    # Subtracting 2 to exclude the "SELECT plan(?);" and "SELECT * FROM finish();"
    return count - 2


@log_function_call
def set_plan_count(test_file_path):
    test_count = count_tests_in_file(test_file_path)
    replace_test_count(test_file_path, test_count)


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
        raise ValueError("Missing one or more required database connection parameters.")

    conn = psycopg2.connect(
        database=database_name,
        user=database_user,
        password=database_user_password,
        host=database_host,
        port=database_port,
    )
    return conn, database_name


@log_function_call()
def format_array_parameter(parameter):
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
        return "ARRAY[]::TEXT[]"
    elif isinstance(parameter, (list, tuple)):
        return f"ARRAY{parameter}::TEXT[]"
    elif isinstance(parameter, (str)):
        return f"ARRAY['{parameter}']::TEXT[]"
    else:
        raise TypeError("Parameter must be a list or tuple")


@log_function_call
def format_directory_element(parameter):
    """
    Removes double quotes and replaces spaces with underscores because I do not
        like then in a directory and file names
    """
    if isinstance(parameter, (str)):
        return parameter.strip('"').replace(" ", "_")
    else:
        raise TypeError("Parameter must be a string")


@log_function_call
def format_single_quote(parameter):
    """
    Have been forced to hard code for certain column defaults! not ideal, I know!

    Maybe someday I can find a much better solution than this.
    """
    if "'" in parameter:
        if "nextval" in parameter or "now" in parameter:
            result = f"$${parameter}$$"
        else:
            result = parameter
    else:
        result = f"'{parameter}'"

    return result


@log_function_call
def remove_schema(parameter):
    if "." in parameter and parameter is not None:
        split_parts = parameter.split(".")
        return split_parts[-1]
    return parameter


@log_function_call
def validate_kinds(reltype, kinds=None):
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
            "m": "multirange",
        },
    }

    valid_kinds = valid_mappings.get(reltype)
    if valid_kinds is None:
        raise ValueError(
            f"Invalid reltype: {reltype}. Valid reltypes are: {list(valid_mappings.keys())}"
        )

    if not kinds:
        raise ValueError(
            f"Invalid kinds must not be empty for reltype '{reltype}'. Valid kinds are: {list(valid_kinds.keys())}"
        )

    invalid_kinds = [k for k in kinds if k not in valid_kinds]
    if invalid_kinds:
        invalid_str = ", ".join(invalid_kinds)
        raise ValueError(
            f"Invalid kind value(s) for reltype '{reltype}': {invalid_str}. Permissible values are: {list(valid_kinds.keys())}"
        )
