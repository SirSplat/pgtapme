import logging
from io import TextIOWrapper
from typing import Dict, Iterable, List, Optional

from src.helpers import format_array_parameter, log_function_call


def _format_scalar(value) -> str:
    if value is None:
        return "NULL"

    escaped = str(value).replace("'", "''")
    return f"'{escaped}'"


def _write_assertion(
    f: TextIOWrapper,
    function_name: str,
    description_template: str,
    args: List,
    array_indexes: Iterable[int],
    description_context: Optional[Dict[str, str]] = None,
) -> None:
    description_context = description_context or {}
    description = description_template.format(**description_context)

    formatted_args = []
    for index, value in enumerate(args):
        if index in array_indexes:
            formatted_args.append(format_array_parameter(value))
        else:
            formatted_args.append(_format_scalar(value))

    formatted_args.append(_format_scalar(description))

    f.write(
        f"  SELECT {function_name}({', '.join(formatted_args)});\n\n"
    )


@log_function_call
def write_select_for_schema_name(
    f: TextIOWrapper,
    function_name: str,
    parameters: List[str],
    description: str,
    schema_name: Optional[str] = None,
) -> None:
    logging.debug(
        f"Writing SELECT statement for function: {function_name} with parameters: {parameters} and description: {description}"
    )
    if schema_name:
        logging.debug(f"Including schema name: {schema_name}")

    """
    Writes a SELECT statement for a SQL function with optional schema_name.

    Args:
        f (file object) -> None: The file object to write the SQL statement to.
        function_name (str) -> None: The name of the SQL function.
        parameters (list or tuple) -> None: The parameters for the SQL function.
        description (str) -> None: A description of the SQL statement.
        schema_name (str, optional) -> None: The schema name. If provided, it includes the schema in the SQL statement.

    Returns:
        None

    Examples:
        Without schema_name:
        >>> write_select_for_schema_name(f: TextIOWrapper, 'my_function', ['param1', 'param2'], 'My custom function')
        # Outputs: f.write("  SELECT my_function(ARRAY['param1', 'param2']::TEXT[], 'My custom function');\n\n")

        With schema_name (e.g., 'my_schema') -> None:
        >>> write_select_for_schema_name(f: TextIOWrapper, 'my_function', ['param1', 'param2'], 'My custom function', schema_name='my_schema')
        # Outputs: f.write("  SELECT my_function(ARRAY['param1', 'param2']::TEXT[], 'my_schema', 'My custom function');\n\n")
    """
    array_str = format_array_parameter(parameters)
    schema_clause = f"'{schema_name}', " if schema_name is not None else ""

    f.write(
        f"  SELECT {function_name}({schema_clause}{array_str}, '{description}');\n\n"
    )
    logging.debug(f"SELECT statement written to file: {f.name}")


@log_function_call
def write_tests_header(f: TextIOWrapper) -> None:
    logging.debug(f"Writing tests header to file: {f.name}")
    f.write(f"BEGIN;\n")
    f.write(f"  SELECT plan(0);\n\n")
    logging.debug("Tests header written successfully.")


@log_function_call
def write_languages_are(f: TextIOWrapper, languages_are: str) -> None:
    logging.debug(
        f"Writing languages_are statement to file: {f.name} with languages: {languages_are}"
    )
    _write_assertion(
        f,
        "languages_are",
        "Cluster should have the correct languages.",
        args=[languages_are],
        array_indexes={0},
    )
    logging.debug("languages_are statement written successfully.")


@log_function_call
def write_tablespaces_are(f: TextIOWrapper, tablespaces_are: str) -> None:
    logging.debug(
        f"Writing tablespaces_are statement to file: {f.name} with tablespaces: {tablespaces_are}"
    )
    _write_assertion(
        f,
        "tablespaces_are",
        "Cluster should have the correct tablespaces.",
        args=[tablespaces_are],
        array_indexes={0},
    )
    logging.debug("tablespaces_are statement written successfully.")


@log_function_call
def write_roles_are(f: TextIOWrapper, roles_are: str) -> None:
    logging.debug(
        f"Writing roles_are statement to file: {f.name} with roles: {roles_are}"
    )
    _write_assertion(
        f,
        "roles_are",
        "Cluster should have the correct roles.",
        args=[roles_are],
        array_indexes={0},
    )
    logging.debug("roles_are statement written successfully.")


@log_function_call
def write_groups_are(f: TextIOWrapper, groups_are: str) -> None:
    logging.debug(
        f"Writing groups_are statement to file: {f.name} with groups: {groups_are}"
    )
    _write_assertion(
        f,
        "groups_are",
        "Cluster should have the correct groups.",
        args=[groups_are],
        array_indexes={0},
    )
    logging.debug("groups_are statement written successfully.")


@log_function_call
def write_users_are(f: TextIOWrapper, users_are: str) -> None:
    _write_assertion(
        f,
        "users_are",
        "Cluster should have the correct users.",
        args=[users_are],
        array_indexes={0},
    )


@log_function_call
def write_casts_are(f: TextIOWrapper, casts_are: str) -> None:
    _write_assertion(
        f,
        "casts_are",
        "Cluster should have the correct casts.",
        args=[casts_are],
        array_indexes={0},
    )


@log_function_call
def write_schemas_are(f: TextIOWrapper, database_name: str, schema_names: str) -> None:
    _write_assertion(
        f,
        "schemas_are",
        "Database {database_name} should have the correct schemas.",
        args=[schema_names],
        array_indexes={0},
        description_context={"database_name": database_name},
    )


@log_function_call
def write_tables_are(f: TextIOWrapper, schema_name: str, tables_are: str) -> None:
    _write_assertion(
        f,
        "tables_are",
        "Schema {schema_name} should have the correct tables.",
        args=[schema_name, tables_are],
        array_indexes={1},
        description_context={"schema_name": schema_name},
    )


@log_function_call
def write_foreign_tables_are(
    f: TextIOWrapper, schema_name: str, foreign_tables_are: str
) -> None:
    _write_assertion(
        f,
        "foreign_tables_are",
        "Schema {schema_name} should have the correct foreign tables.",
        args=[schema_name, foreign_tables_are],
        array_indexes={1},
        description_context={"schema_name": schema_name},
    )


@log_function_call
def write_views_are(f: TextIOWrapper, schema_name: str, views_are: str) -> None:
    _write_assertion(
        f,
        "views_are",
        "Schema {schema_name} should have the correct views.",
        args=[schema_name, views_are],
        array_indexes={1},
        description_context={"schema_name": schema_name},
    )


@log_function_call
def write_materialized_views_are(
    f: TextIOWrapper, schema_name: str, materialized_views_are: str
) -> None:
    _write_assertion(
        f,
        "materialized_views_are",
        "Schema {schema_name} should have the correct materialized views.",
        args=[schema_name, materialized_views_are],
        array_indexes={1},
        description_context={"schema_name": schema_name},
    )


@log_function_call
def write_sequences_are(f: TextIOWrapper, schema_name: str, sequences_are: str) -> None:
    _write_assertion(
        f,
        "sequences_are",
        "Schema {schema_name} should have the correct sequences.",
        args=[schema_name, sequences_are],
        array_indexes={1},
        description_context={"schema_name": schema_name},
    )


@log_function_call
def write_functions_are(f: TextIOWrapper, schema_name: str, functions_are: str) -> None:
    _write_assertion(
        f,
        "functions_are",
        "Schema {schema_name} should have the correct functions.",
        args=[schema_name, functions_are],
        array_indexes={1},
        description_context={"schema_name": schema_name},
    )


@log_function_call
def write_opclasses_are(f: TextIOWrapper, schema_name: str, opclasses_are: str) -> None:
    _write_assertion(
        f,
        "opclasses_are",
        "Schema {schema_name} should have the correct opclasses.",
        args=[schema_name, opclasses_are],
        array_indexes={1},
        description_context={"schema_name": schema_name},
    )


@log_function_call
def write_types_are(f: TextIOWrapper, schema_name: str, types_are: str) -> None:
    _write_assertion(
        f,
        "types_are",
        "Schema {schema_name} should have the correct types.",
        args=[schema_name, types_are],
        array_indexes={1},
        description_context={"schema_name": schema_name},
    )


@log_function_call
def write_domains_are(f: TextIOWrapper, schema_name: str, domains_are: str) -> None:
    _write_assertion(
        f,
        "domains_are",
        "Schema {schema_name} should have the correct domains.",
        args=[schema_name, domains_are],
        array_indexes={1},
        description_context={"schema_name": schema_name},
    )


@log_function_call
def write_enums_are(f: TextIOWrapper, schema_name: str, enums_are: str) -> None:
    _write_assertion(
        f,
        "enums_are",
        "Schema {schema_name} should have the correct enums.",
        args=[schema_name, enums_are],
        array_indexes={1},
        description_context={"schema_name": schema_name},
    )


@log_function_call
def write_operators_are(f: TextIOWrapper, schema_name: str, operators_are: str) -> None:
    _write_assertion(
        f,
        "operators_are",
        "Schema {schema_name} should have the correct operators.",
        args=[schema_name, operators_are],
        array_indexes={1},
        description_context={"schema_name": schema_name},
    )


@log_function_call
def write_extensions_are(
    f: TextIOWrapper, extensions_are: List[str], schema_name: str = None
) -> None:
    write_select_for_schema_name(
        f,
        "extensions_are",
        extensions_are,
        "Cluster should have the correct extensions",
        schema_name,
    )


@log_function_call
def write_partitions_are(
    f: TextIOWrapper, schema_name: str, table_name: str, partitions_are: List[str]
) -> None:
    _write_assertion(
        f,
        "partitions_are",
        "Table {schema_name}.{table_name} should have the correct partitions.",
        args=[schema_name, table_name, partitions_are],
        array_indexes={2},
        description_context={
            "schema_name": schema_name,
            "table_name": table_name,
        },
    )


@log_function_call
def write_columns_are(
    f: TextIOWrapper, schema_name: str, table_name: str, columns_are: List[str]
) -> None:
    _write_assertion(
        f,
        "columns_are",
        "Table {schema_name}.{table_name} should have the correct columns.",
        args=[schema_name, table_name, columns_are],
        array_indexes={2},
        description_context={
            "schema_name": schema_name,
            "table_name": table_name,
        },
    )


@log_function_call
def write_indexes_are(
    f: TextIOWrapper, schema_name: str, table_name: str, indexes_are: List[str]
) -> None:
    _write_assertion(
        f,
        "indexes_are",
        "Table {schema_name}.{table_name} should have the correct indexes.",
        args=[schema_name, table_name, indexes_are],
        array_indexes={2},
        description_context={
            "schema_name": schema_name,
            "table_name": table_name,
        },
    )


@log_function_call
def write_triggers_are(
    f: TextIOWrapper, schema_name: str, table_name: str, triggers_are: List[str]
) -> None:
    _write_assertion(
        f,
        "triggers_are",
        "Table {schema_name}.{table_name} should have the correct triggers.",
        args=[schema_name, table_name, triggers_are],
        array_indexes={2},
        description_context={
            "schema_name": schema_name,
            "table_name": table_name,
        },
    )


@log_function_call
def write_rules_are(
    f: TextIOWrapper, schema_name: str, table_name: str, rules_are: List[str]
) -> None:
    _write_assertion(
        f,
        "rules_are",
        "Table {schema_name}.{table_name} should have the correct rules.",
        args=[schema_name, table_name, rules_are],
        array_indexes={2},
        description_context={
            "schema_name": schema_name,
            "table_name": table_name,
        },
    )


@log_function_call
def write_db_owner_is(f: TextIOWrapper, database_name: str, owner_is: str) -> None:
    _write_assertion(
        f,
        "db_owner_is",
        "Database {database_name} should have the correct owner.",
        args=[database_name, owner_is],
        array_indexes=set(),
        description_context={"database_name": database_name},
    )


@log_function_call
def write_has_schema(f: TextIOWrapper, schema_name: str) -> None:
    _write_assertion(
        f,
        "has_schema",
        "Schema {schema_name} should exist.",
        args=[schema_name],
        array_indexes=set(),
        description_context={"schema_name": schema_name},
    )


@log_function_call
def write_schema_owner_is(f: TextIOWrapper, schema_name: str, owner_is: str) -> None:
    _write_assertion(
        f,
        "schema_owner_is",
        "Schema {schema_name} should have the correct owner.",
        args=[schema_name, owner_is],
        array_indexes=set(),
        description_context={"schema_name": schema_name},
    )


@log_function_call
def write_has_language(f: TextIOWrapper, language_name: str) -> None:
    _write_assertion(
        f,
        "has_language",
        "Language {language_name} should exist.",
        args=[language_name],
        array_indexes=set(),
        description_context={"language_name": language_name},
    )


@log_function_call
def write_language_owner_is(
    f: TextIOWrapper, language_name: str, owner_is: str
) -> None:
    _write_assertion(
        f,
        "language_owner_is",
        "Language {language_name} should have the correct owner.",
        args=[language_name, owner_is],
        array_indexes=set(),
        description_context={"language_name": language_name},
    )


@log_function_call
def write_language_is_trusted(f: TextIOWrapper, language_name: str) -> None:
    _write_assertion(
        f,
        "language_is_trusted",
        "Language {language_name} should exist.",
        args=[language_name],
        array_indexes=set(),
        description_context={"language_name": language_name},
    )


@log_function_call
def write_tablespace_owner_is(
    f: TextIOWrapper, tablespace_name: str, owner_is: str
) -> None:
    _write_assertion(
        f,
        "tablespace_owner_is",
        "Tablespace {tablespace_name} should have the correct owner.",
        args=[tablespace_name, owner_is],
        array_indexes=set(),
        description_context={"tablespace_name": tablespace_name},
    )


@log_function_call
def write_has_tablespace(f: TextIOWrapper, tablespace_name: str) -> None:
    _write_assertion(
        f,
        "has_tablespace",
        "Tablespace {tablespace_name} should exist.",
        args=[tablespace_name],
        array_indexes=set(),
        description_context={"tablespace_name": tablespace_name},
    )


@log_function_call
def write_has_role(f: TextIOWrapper, user_name: str) -> None:
    _write_assertion(
        f,
        "has_role",
        "Role {user_name} should exist.",
        args=[user_name],
        array_indexes=set(),
        description_context={"user_name": user_name},
    )


@log_function_call
def write_has_group(f: TextIOWrapper, user_name: str) -> None:
    _write_assertion(
        f,
        "has_group",
        "Group {user_name} should exist.",
        args=[user_name],
        array_indexes=set(),
        description_context={"user_name": user_name},
    )


@log_function_call
def write_has_user(f: TextIOWrapper, user_name: str) -> None:
    _write_assertion(
        f,
        "has_user",
        "User {user_name} should exist.",
        args=[user_name],
        array_indexes=set(),
        description_context={"user_name": user_name},
    )


@log_function_call
def write_is_member_of(
    f: TextIOWrapper, role_name: str, member_role_names: List[str]
) -> None:
    _write_assertion(
        f,
        "is_member_of",
        "Role {role_name} should have the correct members.",
        args=[role_name, member_role_names],
        array_indexes={1},
        description_context={"role_name": role_name},
    )


@log_function_call
def write_isnt_member_of(
    f: TextIOWrapper, role_name: str, member_role_names: List[str]
) -> None:
    _write_assertion(
        f,
        "isnt_member_of",
        "Role {role_name} should not have  members.",
        args=[role_name, member_role_names],
        array_indexes={1},
        description_context={"role_name": role_name},
    )


@log_function_call
def write_isnt_superuser(f: TextIOWrapper, role_name: str) -> None:
    _write_assertion(
        f,
        "isnt_superuser",
        "Group {role_name} should not be a superuser.",
        args=[role_name],
        array_indexes=set(),
        description_context={"role_name": role_name},
    )


@log_function_call
def write_is_superuser(f: TextIOWrapper, role_name: str) -> None:
    _write_assertion(
        f,
        "is_superuser",
        "Role {role_name} should be a superuser.",
        args=[role_name],
        array_indexes=set(),
        description_context={"role_name": role_name},
    )


@log_function_call
def write_has_extension(
    f: TextIOWrapper, schema_name: str, extension_name: str
) -> None:
    f.write(
        f"  SELECT has_extension('{schema_name}', '{extension_name}', 'Extension {schema_name}.{extension_name} should exist.');\n\n"
    )


@log_function_call
def write_has_table(f: TextIOWrapper, schema_name: str, table_name: str) -> None:
    f.write(
        f"  SELECT has_table('{schema_name}', '{table_name}', 'Table {schema_name}.{table_name} should exist.');\n\n"
    )


@log_function_call
def write_table_owner_is(
    f: TextIOWrapper, schema_name: str, table_name: str, owner_is: str
) -> None:
    f.write(
        f"  SELECT table_owner_is('{schema_name}', '{table_name}', '{owner_is}', 'Table {schema_name}.{table_name} should have the correct owner.');\n\n"
    )


@log_function_call
def write_has_pk(f: TextIOWrapper, schema_name: str, table_name: str) -> None:
    f.write(
        f"  SELECT has_pk('{schema_name}', '{table_name}', 'Table {schema_name}.{table_name} should have a primary key.');\n\n"
    )


@log_function_call
def write_hasnt_pk(f: TextIOWrapper, schema_name: str, table_name: str) -> None:
    f.write(
        f"  SELECT hasnt_pk('{schema_name}', '{table_name}', 'Table {schema_name}.{table_name} should not have a primary key.');\n\n"
    )


@log_function_call
def write_has_fk(f: TextIOWrapper, schema_name: str, table_name: str) -> None:
    f.write(
        f"  SELECT has_fk('{schema_name}', '{table_name}', 'Table {schema_name}.{table_name} should have a foreign key.');\n\n"
    )


@log_function_call
def write_hasnt_fk(f: TextIOWrapper, schema_name: str, table_name: str) -> None:
    f.write(
        f"  SELECT hasnt_fk('{schema_name}', '{table_name}', 'Table {schema_name}.{table_name} should not have a foreign key.');\n\n"
    )


@log_function_call
def write_col_is_pk(
    f: TextIOWrapper, schema_name: str, table_name: str, pk_column_names: List[str]
) -> None:
    array_str = format_array_parameter(pk_column_names)
    f.write(
        f"  SELECT col_is_pk('{schema_name}', '{table_name}', {array_str}, 'Table {schema_name}.{table_name} should have the correct primary key columns.');\n\n"
    )


@log_function_call
def write_col_isnt_pk(
    f: TextIOWrapper, schema_name: str, table_name: str, pk_column_names: List[str]
) -> None:
    array_str = format_array_parameter(pk_column_names)
    f.write(
        f"  SELECT col_isnt_pk('{schema_name}', '{table_name}', {array_str}, 'Table {schema_name}.{table_name} should have the correct primary key columns.');\n\n"
    )


@log_function_call
def write_col_is_fk(
    f: TextIOWrapper, schema_name: str, table_name: str, fk_column_names: List[str]
) -> None:
    array_str = format_array_parameter(fk_column_names)
    f.write(
        f"  SELECT col_is_fk('{schema_name}', '{table_name}', {array_str}, 'Table {schema_name}.{table_name} should have the correct foreign key columns.');\n\n"
    )


@log_function_call
def write_col_isnt_fk(
    f: TextIOWrapper, schema_name: str, table_name: str, fk_column_names: List[str]
) -> None:
    array_str = format_array_parameter(fk_column_names)
    f.write(
        f"  SELECT col_isnt_fk('{schema_name}', '{table_name}', {array_str}, 'Table {schema_name}.{table_name} should have the correct foreign key columns.');\n\n"
    )


@log_function_call
def write_has_unique(f: TextIOWrapper, schema_name: str, table_name: str) -> None:
    f.write(
        f"  SELECT has_unique('{schema_name}', '{table_name}', 'Table {schema_name}.{table_name} should have a unique key.');\n\n"
    )


@log_function_call
def write_col_is_unique(
    f: TextIOWrapper, schema_name: str, table_name: str, uk_column_names: List[str]
) -> None:
    array_str = format_array_parameter(uk_column_names)
    f.write(
        f"  SELECT col_is_unique('{schema_name}', '{table_name}', {array_str}, 'Table {schema_name}.{table_name} should have the correct unique key columns.');\n\n"
    )


@log_function_call
def write_has_check(f: TextIOWrapper, schema_name: str, table_name: str) -> None:
    f.write(
        f"  SELECT has_check('{schema_name}', '{table_name}', 'Table {schema_name}.{table_name} should have a check constraint.');\n\n"
    )


@log_function_call
def write_col_has_check(
    f: TextIOWrapper, schema_name: str, table_name: str, ck_column_names: List[str]
) -> None:
    array_str = format_array_parameter(ck_column_names)
    f.write(
        f"  SELECT col_has_check('{schema_name}', '{table_name}', {array_str}, 'Table {schema_name}.{table_name} should have the correct check constraint columns.');\n\n"
    )


@log_function_call
def write_is_ancestor_of(
    f: TextIOWrapper,
    ancestor_schema: str,
    ancestor_table: str,
    descendent_schema: str,
    descendent_table: str,
) -> None:
    f.write(
        f"  SELECT is_ancestor_of('{ancestor_schema}', '{ancestor_table}', '{descendent_schema}', '{descendent_table}', 'Table {ancestor_schema}.{ancestor_table} should have the correct descendent.');\n\n"
    )


@log_function_call
def write_is_descendent_of(
    f: TextIOWrapper,
    descendent_schema: str,
    descendent_table: str,
    ancestor_schema: str,
    ancestor_table: str,
) -> None:
    f.write(
        f"  SELECT is_descendent_of('{descendent_schema}', '{descendent_table}', '{ancestor_schema}', '{ancestor_table}', 'Table {descendent_schema}.{descendent_table} should have the correct ancestor.');\n\n"
    )


@log_function_call
def write_isnt_ancestor_of(
    f: TextIOWrapper,
    ancestor_schema: str,
    ancestor_table: str,
    descendent_schema: str,
    descendent_table: str,
) -> None:
    f.write(
        f"  SELECT isnt_ancestor_of('{ancestor_schema}', '{ancestor_table}', '{descendent_schema}', '{descendent_table}', 'Table {ancestor_schema}.{ancestor_table} should not have a descendent.');\n\n"
    )


@log_function_call
def write_isnt_descendent_of(
    f: TextIOWrapper,
    descendent_schema: str,
    descendent_table: str,
    ancestor_schema: str,
    ancestor_table: str,
) -> None:
    f.write(
        f"  SELECT isnt_descendent_of('{descendent_schema}', '{descendent_table}', '{ancestor_schema}', '{ancestor_table}', 'Table {descendent_schema}.{descendent_table} should not have an ancestor.');\n\n"
    )


@log_function_call
def write_isnt_partitioned(f: TextIOWrapper, schema_name: str, table_name: str) -> None:
    f.write(
        f"  SELECT isnt_partitioned('{schema_name}', '{table_name}', 'Table {schema_name}.{table_name} should not be partitioned.');\n\n"
    )


@log_function_call
def write_is_partitioned(f: TextIOWrapper, schema_name: str, table_name: str) -> None:
    f.write(
        f"  SELECT is_partitioned('{schema_name}', '{table_name}', 'Table {schema_name}.{table_name} should be partitioned.');\n\n"
    )


@log_function_call
def write_hasnt_inherited_tables(
    f: TextIOWrapper, schema_name: str, table_name: str
) -> None:
    f.write(
        f"  SELECT hasnt_inherited_tables('{schema_name}', '{table_name}', 'Table {schema_name}.{table_name} should not have child tables.');\n\n"
    )


@log_function_call
def write_has_inherited_tables(
    f: TextIOWrapper, schema_name: str, table_name: str
) -> None:
    f.write(
        f"  SELECT has_inherited_tables('{schema_name}', '{table_name}', 'Table {schema_name}.{table_name} should have the correct child tables.');\n\n"
    )


@log_function_call
def write_is_partition_of(
    f: TextIOWrapper,
    schema_name: str,
    table_name: str,
    is_partition_of_rec: List[str],
) -> None:
    f.write(
        f"  SELECT is_partition_of('{schema_name}', '{table_name}', '{is_partition_of_rec.parent_schema}', '{is_partition_of_rec.parent_table}', 'Table {schema_name}.{table_name} should be a partition.');\n\n"
    )


@log_function_call
def write_has_column(
    f: TextIOWrapper, table_schema: str, table_name: str, column_name: str
) -> None:
    f.write(
        f"  SELECT has_column('{table_schema}', '{table_name}', '{column_name}', 'Column {table_schema}.{table_name}.{column_name} should exist.');\n\n"
    )


@log_function_call
def write_col_type_is(
    f: TextIOWrapper,
    schema_name: str,
    table_name: str,
    column_name: str,
    type_schema: str,
    dt_type: str,
) -> None:
    f.write(
        f"  SELECT col_type_is('{schema_name}', '{table_name}', '{column_name}', '{type_schema}', '{dt_type}', 'Column {schema_name}.{table_name}.{column_name} should have the correct type.');\n\n"
    )


@log_function_call
def write_col_hasnt_default(
    f: TextIOWrapper, schema_name: str, table_name: str, column_name: str
) -> None:
    f.write(
        f"  SELECT col_hasnt_default('{schema_name}', '{table_name}', '{column_name}', 'Column {schema_name}.{table_name}.{column_name} should not have DEFAULT.');\n\n"
    )


@log_function_call
def write_col_has_default(
    f: TextIOWrapper, schema_name: str, table_name: str, column_name: str
) -> None:
    f.write(
        f"  SELECT col_has_default('{schema_name}', '{table_name}', '{column_name}', 'Column {schema_name}.{table_name}.{column_name} should have DEFAULT.');\n\n"
    )


@log_function_call
def write_col_is_null(
    f: TextIOWrapper, schema_name: str, table_name: str, column_name: str
) -> None:
    f.write(
        f"  SELECT col_is_null('{schema_name}', '{table_name}', '{column_name}', 'Column {schema_name}.{table_name}.{column_name} should not be NOT NULL.');\n\n"
    )


@log_function_call
def write_col_not_null(
    f: TextIOWrapper, schema_name: str, table_name: str, column_name: str
) -> None:
    f.write(
        f"  SELECT col_not_null('{schema_name}', '{table_name}', '{column_name}', 'Column {schema_name}.{table_name}.{column_name} should be NOT NULL.');\n\n"
    )


@log_function_call
def write_has_type(f: TextIOWrapper, type_schema: str, type_name: str) -> None:
    f.write(
        f"  SELECT has_type('{type_schema}', '{type_name}', 'Data type {type_schema}.{type_name} should exist.');\n\n"
    )


@log_function_call
def write_col_default_is(
    f: TextIOWrapper,
    schema_name: str,
    table_name: str,
    column_name: str,
    column_default: str,
) -> None:
    f.write(
        f"  SELECT col_default_is('{schema_name}', '{table_name}', '{column_name}', {column_default}, 'Column {schema_name}.{table_name}.{column_name} should have the correct default.');\n\n"
    )


@log_function_call
def write_has_index(
    f: TextIOWrapper,
    schema_name: str,
    table_name: str,
    index_name: str,
    column_names: List[str],
) -> None:
    array_str = format_array_parameter(column_names)
    f.write(
        f"  SELECT has_index('{schema_name}', '{table_name}', '{index_name}', {array_str}, 'Index {schema_name}.{table_name}.{index_name} should exist.');\n\n"
    )


@log_function_call
def write_index_owner_is(
    f: TextIOWrapper,
    schema_name: str,
    table_name: str,
    index_name: str,
    owner_is: str,
) -> None:
    f.write(
        f"  SELECT index_owner_is('{schema_name}', '{table_name}', '{index_name}', '{owner_is}', 'Index {schema_name}.{table_name}.{index_name} should have the correct owner.');\n\n"
    )


@log_function_call
def write_index_is_unique(
    f: TextIOWrapper, schema_name: str, table_name: str, index_name: str
) -> None:
    f.write(
        f"  SELECT index_is_unique('{schema_name}', '{table_name}', '{index_name}', 'Index {schema_name}.{table_name}.{index_name} should be a unique index.');\n\n"
    )


@log_function_call
def write_index_type_is(
    f: TextIOWrapper,
    schema_name: str,
    table_name: str,
    index_name: str,
    index_type: str,
) -> None:
    f.write(
        f"  SELECT index_is_type('{schema_name}', '{table_name}', '{index_name}', '{index_type}', 'Index {schema_name}.{table_name}.{index_name} should be of the correct type.');\n\n"
    )


@log_function_call
def write_index_is_clustered(
    f: TextIOWrapper, schema_name: str, table_name: str, index_name: str
) -> None:
    f.write(
        f"  SELECT is_clustered('{schema_name}', '{table_name}', '{index_name}', 'Index {schema_name}.{table_name}.{index_name} should be clustered.');\n\n"
    )


@log_function_call
def write_index_is_primary(
    f: TextIOWrapper, schema_name: str, table_name: str, index_name: str
) -> None:
    f.write(
        f"  SELECT index_is_primary('{schema_name}', '{table_name}', '{index_name}', 'Index {schema_name}.{table_name}.{index_name} should be a primary key index.');\n\n"
    )


@log_function_call
def write_has_rule(
    f: TextIOWrapper, table_schema: str, table_name: str, rule_name: str
) -> None:
    f.write(
        f"  SELECT has_rule('{table_schema}', '{table_name}', '{rule_name}', 'Rule {table_schema}.{table_name}.{rule_name} should exist.');\n\n"
    )


@log_function_call
def write_rule_is_instead(
    f: TextIOWrapper, table_schema: str, table_name: str, rule_name: str
) -> None:
    f.write(
        f"  SELECT rule_is_instead('{table_schema}', '{table_name}', '{rule_name}', 'Rule {table_schema}.{table_name}.{rule_name} should be a instead rule.');\n\n"
    )


@log_function_call
def write_rule_is_on(
    f: TextIOWrapper,
    table_schema: str,
    table_name: str,
    rule_name: str,
    rule_is_on: str,
) -> None:
    f.write(
        f"  SELECT rule_is_on('{table_schema}', '{table_name}', '{rule_name}', '{rule_is_on}', 'Rule {table_schema}.{table_name}.{rule_name} should be on {rule_is_on}.');\n\n"
    )


@log_function_call
def write_fk_ok(
    f: TextIOWrapper,
    fk_schema: str,
    fk_table: str,
    fk_columns: List[str],
    pk_schema: str,
    pk_table: str,
    pk_columns: List[str],
    fk_name: str,
) -> None:
    fk_col_array = format_array_parameter(fk_columns)
    pk_col_array = format_array_parameter(pk_columns)
    f.write(
        f"  SELECT fk_ok('{fk_schema}', '{fk_table}', {fk_col_array}, '{pk_schema}', '{pk_table}', {pk_col_array}, 'Foreign key {fk_schema}.{fk_table}.{fk_name} should exist.');\n\n"
    )


@log_function_call
def write_has_trigger(
    f: TextIOWrapper, trg_schema: str, trg_table: str, trg_name: str
) -> None:
    f.write(
        f"  SELECT has_trigger('{trg_schema}', '{trg_table}', '{trg_name}', 'Trigger {trg_schema}.{trg_table}.{trg_name} should exist.');\n\n"
    )


@log_function_call
def write_trigger_is(
    f: TextIOWrapper,
    trg_schema: str,
    trg_table: str,
    trg_name: str,
    trg_function_schema: str,
    trg_function: str,
) -> None:
    f.write(
        f"  SELECT trigger_is('{trg_schema}', '{trg_table}', '{trg_name}', '{trg_function_schema}', '{trg_function}', 'Trigger {trg_schema}.{trg_table}.{trg_name} should exist.');\n\n"
    )


@log_function_call
def write_has_function(
    f: TextIOWrapper,
    function_schema: str,
    function_name: str,
    function_args: List[str] = None,
    pro_signature: str = None,
) -> None:
    array_str = format_array_parameter(function_args)
    f.write(
        f"  SELECT has_function('{function_schema}', '{function_name}', {array_str}, 'Function {function_schema}.{pro_signature} should exist.');\n\n"
    )


@log_function_call
def write_sequence_owner_is(
    f: TextIOWrapper, schema_name: str, sequence_name: str, owner_is: str
) -> None:
    f.write(
        f"  SELECT sequence_owner_is('{schema_name}', '{sequence_name}', '{owner_is}', 'Sequence {schema_name}.{sequence_name} should have the correct owner.');\n\n"
    )


@log_function_call
def write_has_sequence(f: TextIOWrapper, schema_name: str, sequence_name: str) -> None:
    f.write(
        f"  SELECT has_sequence('{schema_name}', '{sequence_name}', 'Sequence {schema_name}.{sequence_name} should exist.');\n\n"
    )


@log_function_call
def write_view_owner_is(
    f: TextIOWrapper, schema_name: str, view_name: str, owner_is: str
) -> None:
    f.write(
        f"  SELECT view_owner_is('{schema_name}', '{view_name}', '{owner_is}', 'View {schema_name}.{view_name} should have the correct owner.');\n\n"
    )


@log_function_call
def write_has_view(f: TextIOWrapper, schema_name: str, view_name: str) -> None:
    f.write(
        f"  SELECT has_view('{schema_name}', '{view_name}', 'View {schema_name}.{view_name} should exist.');\n\n"
    )


@log_function_call
def write_materialized_view_owner_is(
    f: TextIOWrapper, mtv_schema: str, mtv_name: str, mtv_owner: str
) -> None:
    f.write(
        f"  SELECT materialized_view_owner_is('{mtv_schema}', '{mtv_name}', '{mtv_owner}', 'Materialized view {mtv_schema}.{mtv_name} should have the correct owner.');\n\n"
    )


@log_function_call
def write_has_materialized_view(
    f: TextIOWrapper, mtv_schema: str, mtv_name: str
) -> None:
    f.write(
        f"  SELECT has_materialized_view('{mtv_schema}', '{mtv_name}', 'Materialized view {mtv_schema}.{mtv_name} should exist.');\n\n"
    )


@log_function_call
def write_has_foreign_table(f: TextIOWrapper, mtv_schema: str, mtv_name: str) -> None:
    f.write(
        f"  SELECT has_materialized_view('{mtv_schema}', '{mtv_name}', 'Materialized view {mtv_schema}.{mtv_name} should exist.');\n\n"
    )


@log_function_call
def write_has_foreign_table(f: TextIOWrapper, ft_schema: str, ft_name: str) -> None:
    f.write(
        f"  SELECT has_foreign_table('{ft_schema}', '{ft_name}', 'Foreign table {ft_schema}.{ft_name} should exist.');\n\n"
    )


@log_function_call
def write_foreign_table_owner_is(
    f: TextIOWrapper, ft_schema: str, ft_name: str, ft_owner: str
) -> None:
    f.write(
        f"  SELECT foreign_table_owner_is('{ft_schema}', '{ft_name}', '{ft_owner}', 'Foreign table {ft_schema}.{ft_name} should have the correct owner.');\n\n"
    )


@log_function_call
def write_function_owner_is(
    f: TextIOWrapper,
    function_schema: str,
    function_name: str,
    function_args: List[str],
    function_owner_is: str,
    pro_signature: str,
) -> None:
    array_str = format_array_parameter(function_args)
    f.write(
        f"  SELECT function_owner_is('{function_schema}', '{function_name}', {array_str}, '{function_owner_is}', 'Function {function_schema}.{pro_signature} should have the correct owner.');\n\n"
    )


@log_function_call
def write_function_language_is(
    f: TextIOWrapper,
    function_schema: str,
    function_name: str,
    function_args: List[str],
    function_language: str,
    pro_signature: str,
) -> None:
    array_str = format_array_parameter(function_args)
    f.write(
        f"  SELECT function_lang_is('{function_schema}', '{function_name}', {array_str}, '{function_language}', 'Function {function_schema}.{pro_signature} should have the correct language.');\n\n"
    )


@log_function_call
def write_function_returns(
    f: TextIOWrapper,
    function_schema: str,
    function_name: str,
    function_args: List[str],
    function_returns: str,
    pro_signature: str,
) -> None:
    array_str = format_array_parameter(function_args)
    f.write(
        f"  SELECT function_returns('{function_schema}', '{function_name}', {array_str}, '{function_returns}', 'Function {function_schema}.{pro_signature} should have the correct return type.');\n\n"
    )


@log_function_call
def write_function_is_definer(
    f: TextIOWrapper,
    function_schema: str,
    function_name: str,
    function_args: List[str],
    pro_signature: str,
) -> None:
    array_str = format_array_parameter(function_args)
    f.write(
        f"  SELECT is_definer('{function_schema}', '{function_name}', {array_str}, 'Function {function_schema}.{pro_signature} should have the correct security definer.');\n\n"
    )


@log_function_call
def write_function_isnt_definer(
    f: TextIOWrapper,
    function_schema: str,
    function_name: str,
    function_args: List[str],
    pro_signature: str,
) -> None:
    array_str = format_array_parameter(function_args)
    f.write(
        f"  SELECT isnt_definer('{function_schema}', '{function_name}', {array_str}, 'Function {function_schema}.{pro_signature} should have the correct security invoker.');\n\n"
    )


@log_function_call
def write_function_is_strict(
    f: TextIOWrapper,
    function_schema: str,
    function_name: str,
    function_args: List[str],
    pro_signature: str,
) -> None:
    array_str = format_array_parameter(function_args)
    f.write(
        f"  SELECT is_strict('{function_schema}', '{function_name}', {array_str}, 'Function {function_schema}.{pro_signature} should be strict.');\n\n"
    )


@log_function_call
def write_function_isnt_strict(
    f: TextIOWrapper,
    function_schema: str,
    function_name: str,
    function_args: List[str],
    pro_signature: str,
) -> None:
    array_str = format_array_parameter(function_args)
    f.write(
        f"  SELECT isnt_strict('{function_schema}', '{function_name}', {array_str}, 'Function {function_schema}.{pro_signature} should not be strict.');\n\n"
    )


@log_function_call
def write_function_is_normal_function(
    f: TextIOWrapper,
    function_schema: str,
    function_name: str,
    function_args: List[str],
    pro_signature: str,
) -> None:
    array_str = format_array_parameter(function_args)
    f.write(
        f"  SELECT is_normal_function('{function_schema}', '{function_name}', {array_str}, 'Function {function_schema}.{pro_signature} should be a normal function.');\n\n"
    )


@log_function_call
def write_function_isnt_normal_function(
    f: TextIOWrapper,
    function_schema: str,
    function_name: str,
    function_args: List[str],
    pro_signature: str,
) -> None:
    array_str = format_array_parameter(function_args)
    f.write(
        f"  SELECT isnt_normal_function('{function_schema}', '{function_name}', {array_str}, 'Function {function_schema}.{pro_signature} should not be a normal function.');\n\n"
    )


@log_function_call
def write_function_is_aggregate(
    f: TextIOWrapper,
    function_schema: str,
    function_name: str,
    function_args: List[str],
    pro_signature: str,
) -> None:
    array_str = format_array_parameter(function_args)
    f.write(
        f"  SELECT is_aggregate('{function_schema}', '{function_name}', {array_str}, 'Function {function_schema}.{pro_signature} should be an aggregate function.');\n\n"
    )


@log_function_call
def write_function_isnt_aggregate(
    f: TextIOWrapper,
    function_schema: str,
    function_name: str,
    function_args: List[str],
    pro_signature: str,
) -> None:
    array_str = format_array_parameter(function_args)
    f.write(
        f"  SELECT isnt_aggregate('{function_schema}', '{function_name}', {array_str}, 'Function {function_schema}.{pro_signature} should not be an aggregate function.');\n\n"
    )


@log_function_call
def write_function_is_window(
    f: TextIOWrapper,
    function_schema: str,
    function_name: str,
    function_args: List[str],
    pro_signature: str,
) -> None:
    array_str = format_array_parameter(function_args)
    f.write(
        f"  SELECT is_window('{function_schema}', '{function_name}', {array_str}, 'Function {function_schema}.{pro_signature} should be a window function.');\n\n"
    )


@log_function_call
def write_function_isnt_window(
    f: TextIOWrapper,
    function_schema: str,
    function_name: str,
    function_args: List[str],
    pro_signature: str,
) -> None:
    array_str = format_array_parameter(function_args)
    f.write(
        f"  SELECT isnt_window('{function_schema}', '{function_name}', {array_str}, 'Function {function_schema}.{pro_signature} should not be a window function.');\n\n"
    )


@log_function_call
def write_function_is_procedure(
    f: TextIOWrapper,
    function_schema: str,
    function_name: str,
    function_args: List[str],
    pro_signature: str,
) -> None:
    array_str = format_array_parameter(function_args)
    f.write(
        f"  SELECT is_procedure('{function_schema}', '{function_name}', {array_str}, 'Function {function_schema}.{pro_signature} should be a procedure.');\n\n"
    )


@log_function_call
def write_function_isnt_procedure(
    f: TextIOWrapper,
    function_schema: str,
    function_name: str,
    function_args: List[str],
    pro_signature: str,
) -> None:
    array_str = format_array_parameter(function_args)
    f.write(
        f"  SELECT isnt_procedure('{function_schema}', '{function_name}', {array_str}, 'Function {function_schema}.{pro_signature} should not be a procedure.');\n\n"
    )


@log_function_call
def write_function_volatility_is(
    f: TextIOWrapper,
    function_schema: str,
    function_name: str,
    function_args: List[str],
    function_volatility: str,
    pro_signature: str,
) -> None:
    array_str = format_array_parameter(function_args)
    f.write(
        f"  SELECT volatility_is('{function_schema}', '{function_name}', {array_str}, '{function_volatility}', 'Function {function_schema}.{pro_signature} should have the correct volatility.');\n\n"
    )


@log_function_call
def write_has_enum(f: TextIOWrapper, enum_schema: str, enum_name: str) -> None:
    f.write(
        f"  SELECT has_enum('{enum_schema}', '{enum_name}', 'ENUM {enum_schema}.{enum_name} should exist.');\n\n"
    )


@log_function_call
def write_enum_has_labels(
    f: TextIOWrapper, enum_schema: str, enum_name: str, enum_label: List[str]
) -> None:
    array_str = format_array_parameter(enum_label)
    f.write(
        f"  SELECT enum_has_labels('{enum_schema}', '{enum_name}', {array_str}, 'ENUM {enum_schema}.{enum_name} should have the correct labels.');\n\n"
    )


@log_function_call
def write_has_domain(f: TextIOWrapper, schema: str, name: str) -> None:
    f.write(
        f"  SELECT has_domain('{schema}', '{name}', 'Domain {schema}.{name} should exist.');\n\n"
    )


@log_function_call
def write_type_owner_is(f: TextIOWrapper, schema: str, name: str, owner: str) -> None:
    f.write(
        f"  SELECT type_owner_is('{schema}', '{name}', '{owner}', 'Type {schema}.{name} should have the correct owner.');\n\n"
    )


@log_function_call
def write_domain_type_is(
    f: TextIOWrapper, schema: str, name: str, t_schema: str, t_name: str
) -> None:
    f.write(
        f"  SELECT domain_type_is('{schema}', '{name}', '{t_schema}', '{t_name}', 'Domain {schema}.{name} should have the correct type.');\n\n"
    )


@log_function_call
def write_tests_footer(f: TextIOWrapper) -> None:
    f.write(f"  SELECT * FROM finish();\n")
    f.write(f"ROLLBACK;\n")
