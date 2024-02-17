import logging
from io import TextIOWrapper
from typing import TextIO

from src.getters.get_catalog_data import (
    get_columns_are,
    get_con_columns_are,
    get_con_columns_arent,
    get_indexes_are,
    get_is_partition_of,
    get_partitions_are,
    get_rules_are,
    get_table_family_tree,
    get_table_info,
    get_triggers_are,
)
from src.helpers import create_file_path, log_function_call, set_plan_count
from src.writers.write_pgtap_tests import (
    write_col_has_check,
    write_col_is_fk,
    write_col_is_pk,
    write_col_is_unique,
    write_col_isnt_fk,
    write_col_isnt_pk,
    write_columns_are,
    write_has_check,
    write_has_fk,
    write_has_inherited_tables,
    write_has_pk,
    write_has_role,
    write_has_schema,
    write_has_table,
    write_has_unique,
    write_hasnt_fk,
    write_hasnt_inherited_tables,
    write_hasnt_pk,
    write_indexes_are,
    write_is_ancestor_of,
    write_is_descendent_of,
    write_is_partition_of,
    write_is_partitioned,
    write_isnt_partitioned,
    write_partitions_are,
    write_rules_are,
    write_table_owner_is,
    write_tests_footer,
    write_tests_header,
    write_triggers_are,
)


@log_function_call(
    log_level=logging.INFO,
    info_message="TODO: Determine the usefulness of the 'isnt_ancestor_of' and 'isnt_descentent_of' tests.",
)
def process_data(cursor: TextIO, output_dir: str, module_type: str) -> None:
    for data in get_table_info(cursor):
        file_path = create_file_path(
            output_dir,
            "databases",
            data.database_name,
            "schemas",
            data.schema_name,
            "tables",
            data.table_name,
            data.table_name,
        )

        try:
            with open(file_path, "w") as f:
                write_tests(
                    f,
                    cursor,
                    schema_name=data.schema_name,
                    table_name=data.table_name,
                    owner_is=data.owner_is,
                    has_constraints=data.has_constraints,
                )
        except Exception as e:
            logging.error(f"Failed to generate tests for {module_type}: {e}.")

        set_plan_count(file_path)


@log_function_call
def write_tests(
    f: TextIOWrapper,
    cursor: TextIO,
    schema_name: str,
    table_name: str,
    owner_is: str,
    has_constraints: str,
) -> None:
    write_tests_header(f)

    write_has_schema(f, schema_name)
    write_has_table(f, schema_name, table_name)
    write_has_role(f, owner_is)
    write_table_owner_is(f, schema_name, table_name, owner_is)

    partitions_are = get_partitions_are(cursor, schema_name, table_name, "p")
    write_partitions_are(f, schema_name, table_name, partitions_are)

    columns_are = get_columns_are(cursor, schema_name, table_name)
    write_columns_are(f, schema_name, table_name, columns_are)

    indexes_are = get_indexes_are(cursor, schema_name, table_name)
    write_indexes_are(f, schema_name, table_name, indexes_are)

    triggers_are = get_triggers_are(cursor, schema_name, table_name)
    write_triggers_are(f, schema_name, table_name, triggers_are)

    rules_are = get_rules_are(cursor, schema_name, table_name)
    write_rules_are(f, schema_name, table_name, rules_are)

    if has_constraints.get("has_pk"):
        write_has_pk(f, schema_name, table_name)

        con_columns_are = get_con_columns_are(cursor, schema_name, table_name, "p")

        for record in con_columns_are:
            write_col_is_pk(f, schema_name, table_name, record.columns_are)

        con_columns_arent = get_con_columns_arent(cursor, schema_name, table_name, "p")

        for record in con_columns_arent:
            write_col_isnt_pk(f, schema_name, table_name, record.columns_are)
    elif not has_constraints.get("has_pk"):
        write_hasnt_pk(f, schema_name, table_name)

        con_columns_arent = get_con_columns_arent(cursor, schema_name, table_name, "p")

        for record in con_columns_arent:
            write_col_isnt_pk(f, schema_name, table_name, record.columns_are)

    if has_constraints.get("has_fk"):
        write_has_fk(f, schema_name, table_name)

        con_columns_are = get_con_columns_are(cursor, schema_name, table_name, "f")

        for record in con_columns_are:
            write_col_is_fk(f, schema_name, table_name, record.columns_are)

        con_columns_arent = get_con_columns_arent(cursor, schema_name, table_name, "f")

        for record in con_columns_arent:
            write_col_isnt_fk(f, schema_name, table_name, record.columns_are)
    elif not has_constraints.get("has_fk"):
        write_hasnt_fk(f, schema_name, table_name)

        con_columns_arent = get_con_columns_arent(cursor, schema_name, table_name, "f")

        for record in con_columns_arent:
            write_col_isnt_fk(f, schema_name, table_name, record.columns_are)

    if has_constraints.get("has_unique"):
        write_has_unique(f, schema_name, table_name)

        con_columns_are = get_con_columns_are(cursor, schema_name, table_name, "u")

        for record in con_columns_are:
            write_col_is_unique(f, schema_name, table_name, record.columns_are)

    if has_constraints.get("has_check"):
        write_has_check(f, schema_name, table_name)

        con_columns_are = get_con_columns_are(cursor, schema_name, table_name, "c")

        for record in con_columns_are:
            write_col_has_check(f, schema_name, table_name, record.columns_are)

    family_tree = get_table_family_tree(cursor)

    for branch in family_tree:
        if (
            branch.ancestor_schema == schema_name
            and branch.ancestor_table == table_name
        ):
            write_is_ancestor_of(
                f,
                branch.ancestor_schema,
                branch.ancestor_table,
                branch.descendent_schema,
                branch.descendent_table,
            )

        if (
            branch.descendent_schema == schema_name
            and branch.descendent_table == table_name
        ):
            write_is_descendent_of(
                f,
                branch.descendent_schema,
                branch.descendent_table,
                branch.ancestor_schema,
                branch.ancestor_table,
            )

        # if branch.ancestor_schema != schema_name and branch.ancestor_table != table_name:
        #     write_isnt_ancestor_of(f, schema_name, table_name, branch.descendent_schema, branch.descendent_table)

        # if branch.descendent_schema != schema_name and branch.descendent_table != table_name:
        #     write_isnt_descendent_of(f, schema_name, table_name, branch.ancestor_schema, branch.ancestor_table)

    if partitions_are:
        write_is_partitioned(f, schema_name, table_name)
    else:
        write_isnt_partitioned(f, schema_name, table_name)

    partition_records = get_is_partition_of(cursor, schema_name, table_name)

    for record in partition_records:
        write_is_partition_of(f, schema_name, table_name, record)

    inherited_records = get_partitions_are(cursor, schema_name, table_name, "r")
    if inherited_records:
        write_has_inherited_tables(f, schema_name, table_name)
    else:
        write_hasnt_inherited_tables(f, schema_name, table_name)

    write_tests_footer(f)
