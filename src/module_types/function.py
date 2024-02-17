import logging
from typing import TextIO, List
from io import TextIOWrapper

from src.getters.get_catalog_data import get_function_info
from src.helpers import create_file_path, log_function_call, set_plan_count
from src.writers.write_pgtap_tests import (
    write_function_is_aggregate,
    write_function_is_definer,
    write_function_is_normal_function,
    write_function_is_procedure,
    write_function_is_strict,
    write_function_is_window,
    write_function_isnt_aggregate,
    write_function_isnt_definer,
    write_function_isnt_normal_function,
    write_function_isnt_procedure,
    write_function_isnt_strict,
    write_function_isnt_window,
    write_function_language_is,
    write_function_owner_is,
    write_function_returns,
    write_function_volatility_is,
    write_has_function,
    write_has_role,
    write_has_schema,
    write_tests_footer,
    write_tests_header,
)


@log_function_call
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    for data in get_function_info(cursor):
        if not data:
            logging.error("There was a problem with the %s: %s", module_type, data)
            return

        file_path = create_file_path(
            output_dir,
            "databases",
            data.database_name,
            "schemas",
            data.pro_schema,
            "functions",
            data.pro_name,
            data.pro_signature,
        )

        try:
            with open(file_path, "w") as f:
                write_tests(
                    f,
                    pro_schema=data.pro_schema,
                    pro_name=data.pro_name,
                    pro_owner=data.pro_owner,
                    pro_lang=data.pro_lang,
                    is_strict=data.is_strict,
                    is_definer=data.is_definer,
                    pro_volatility=data.volatility,
                    pro_kind=data.pro_kind,
                    pro_returns=data.pro_returns,
                    pro_args=data.pro_args,
                    pro_signature=data.pro_signature,
                )
        except Exception as e:
            logging.error(f"Failed to generate tests for {module_type}: {e}.")

        set_plan_count(file_path)


@log_function_call
def write_tests(
    f: TextIOWrapper,
    pro_schema: str,
    pro_name: str,
    pro_owner: str,
    pro_lang: str,
    is_strict: str,
    is_definer: str,
    pro_volatility: str,
    pro_kind: str,
    pro_returns: str,
    pro_args: List[str],
    pro_signature: str,
) -> None:
    write_tests_header(f)

    write_has_schema(f, pro_schema)
    write_has_function(f, pro_schema, pro_name, pro_args)
    write_has_role(f, pro_owner)
    write_function_owner_is(f, pro_schema, pro_name, pro_args, pro_owner, pro_signature)
    write_function_language_is(
        f, pro_schema, pro_name, pro_args, pro_lang, pro_signature
    )
    write_function_returns(
        f, pro_schema, pro_name, pro_args, pro_returns, pro_signature
    )

    if is_definer:
        write_function_is_definer(f, pro_schema, pro_name, pro_args, pro_signature)
    else:
        write_function_isnt_definer(f, pro_schema, pro_name, pro_args, pro_signature)

    if is_strict:
        write_function_is_strict(f, pro_schema, pro_name, pro_args, pro_signature)
    else:
        write_function_isnt_strict(f, pro_schema, pro_name, pro_args, pro_signature)

    if pro_kind == "f":
        write_function_is_normal_function(
            f, pro_schema, pro_name, pro_args, pro_signature
        )
    else:
        write_function_isnt_normal_function(
            f, pro_schema, pro_name, pro_args, pro_signature
        )

    if pro_kind == "a":
        write_function_is_aggregate(f, pro_schema, pro_name, pro_args, pro_signature)
    else:
        write_function_isnt_aggregate(f, pro_schema, pro_name, pro_args, pro_signature)

    if pro_kind == "w":
        write_function_is_window(f, pro_schema, pro_name, pro_args, pro_signature)
    else:
        write_function_isnt_window(f, pro_schema, pro_name, pro_args, pro_signature)

    if pro_kind == "p":
        write_function_is_procedure(f, pro_schema, pro_name, pro_args, pro_signature)
    else:
        write_function_isnt_procedure(f, pro_schema, pro_name, pro_args, pro_signature)

    write_function_volatility_is(
        f, pro_schema, pro_name, pro_args, pro_volatility, pro_signature
    )

    write_tests_footer(f)
