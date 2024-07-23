import json
import logging
import os
from importlib import import_module

from psycopg2 import extras
from src.helpers import configure_logging, connect_to_database, get_modules


def main() -> None:
    configure_logging()

    logging.debug("Script started.")

    script_directory = os.path.dirname(os.path.realpath(__file__))
    config_path = os.path.join(script_directory, "config.json")

    try:
        with open(config_path, "r") as config_file:
            config = json.load(config_file)
        logging.debug("Configuration loaded succesfully.")
    except FileNotFoundError:
        logging.error("config.json file not found.")
        return
    except json.JSONDecodeError as e:
        logging.error(f"Error decoding config.json: {e}")
        return
    except KeyError as e:
        logging.error(f"Missing or invalid config key: {e}")
        return
    except Exception as e:
        logging.error(
            "An unexpected error occurred while loading the config.", exc_info=True
        )
        return

    conn, dbname = connect_to_database()

    logging.debug(f"Connected to database: {dbname}")

    cursor = conn.cursor(cursor_factory=extras.NamedTupleCursor)
    output_dir = os.path.join(config["output_dir"], dbname)

    logging.debug(f"Output directory set to: {output_dir}")
    logging.debug(f"Starting reverse engineering of database: {dbname}")

    module_types = get_modules(config)

    for module_type in module_types:
        logging.debug(f"Processing module: {module_type}")

        module = import_module(f"src.module_types.{module_type}", "t")
        process_data_function = getattr(module, "process_data", None)

        if process_data_function:
            process_data_function(cursor, output_dir, module_type)
            logging.debug(f"Completed processing module type: {module_type}")
        else:
            logging.debug(f"No process_data function found for module type: {module_type}")

    logging.debug("Completed reverse engineering of schema.")

    cursor.close()
    conn.close()

    logging.debug("Database connection closed.")
    logging.debug("Script finished.")

if __name__ == "__main__":
    main()
