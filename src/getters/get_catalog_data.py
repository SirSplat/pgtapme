import logging
from typing import List, TextIO

from src.helpers import log_function_call, validate_kinds


@log_function_call
def get_tablespaces_are(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY_AGG( spcname ) AS tablespaces_are
        FROM
            pg_catalog.pg_tablespace
    """
    )
    records = cursor.fetchone()
    return records.tablespaces_are


@log_function_call
def get_roles_are(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY_AGG( rolname ) AS roles_are
        FROM
            pg_catalog.pg_roles
    """
    )
    records = cursor.fetchone()
    return records.roles_are


@log_function_call
def get_groups_are(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY_AGG( rolname ) AS groups_are
        FROM
            pg_catalog.pg_roles
        WHERE
            NOT rolcanlogin
    """
    )
    records = cursor.fetchone()
    return records.groups_are


@log_function_call
def get_users_are(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY_AGG( rolname ) AS users_are
        FROM
            pg_catalog.pg_roles
        WHERE
            rolcanlogin
    """
    )
    records = cursor.fetchone()
    return records.users_are


@log_function_call
def get_languages_are(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY_AGG( lanname ) AS languages_are
        FROM
            pg_catalog.pg_language
        WHERE
            lanispl
    """
    )
    records = cursor.fetchone()
    return records.languages_are


@log_function_call
def get_casts_are(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY_AGG(
                pg_catalog.format_type( castsource, NULL ) || ' AS ' ||
                pg_catalog.format_type( casttarget, NULL )
            ) AS casts_are
        FROM
            pg_catalog.pg_cast
    """
    )
    records = cursor.fetchone()
    return records.casts_are


@log_function_call
def get_extensions_are(cursor: TextIO, schema_name: str) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY_AGG( pg_extension.extname ) AS extensions_are
        FROM
            pg_catalog.pg_extension
            JOIN pg_catalog.pg_namespace ON ( pg_namespace.oid = pg_extension.extnamespace )
        WHERE
            pg_namespace.nspname = %s OR
            %s = ''
    """,
        (schema_name, schema_name),
    )
    records = cursor.fetchone()
    return records.extensions_are


@log_function_call
def get_relations_are(
    cursor: TextIO, schema_name: str, kinds: List[str] = None
) -> List[str]:
    validate_kinds("pg_class", kinds)
    cursor.execute(
        """
        SELECT
            ARRAY_AGG( c.relname ) AS relations_are
        FROM
            pg_catalog.pg_class AS c
            JOIN pg_catalog.pg_namespace AS n ON (
                n.oid = c.relnamespace AND
                n.nspname = %s
            )
        WHERE
            c.relkind = ANY( %s )
    """,
        (schema_name, [kinds]),
    )
    records = cursor.fetchone()
    return records.relations_are


@log_function_call
def get_tables_are(cursor: TextIO, schema_name: str) -> List[str]:
    return get_relations_are(cursor, schema_name, ["p", "r"])


@log_function_call
def get_foreign_tables_are(cursor: TextIO, schema_name: str) -> List[str]:
    return get_relations_are(cursor, schema_name, ["f"])


@log_function_call
def get_views_are(cursor: TextIO, schema_name: str) -> List[str]:
    return get_relations_are(cursor, schema_name, ["v"])


@log_function_call
def get_materialized_views_are(cursor: TextIO, schema_name: str) -> List[str]:
    return get_relations_are(cursor, schema_name, ["m"])


@log_function_call
def get_sequences_are(cursor: TextIO, schema_name: str) -> List[str]:
    return get_relations_are(cursor, schema_name, ["S"])


@log_function_call
def get_schemas_are(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY_AGG( nspname ) AS schemas_are
        FROM
            pg_catalog.pg_namespace
        WHERE
            pg_namespace.nspname NOT IN ( 'information_schema', 'pg_catalog' ) AND
            pg_namespace.nspname NOT ILIKE 'pg_t%'
    """
    )
    records = cursor.fetchone()
    return records.schemas_are


@log_function_call
def get_functions_are(cursor: TextIO, schema_name: str) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY_AGG( p.proname ) AS functions_are
        FROM
            pg_catalog.pg_proc AS p
            JOIN pg_catalog.pg_namespace AS n ON (
                n.oid = p.pronamespace AND
                n.nspname = %s
            )
    """,
        (schema_name,),
    )
    records = cursor.fetchone()
    return records.functions_are


@log_function_call
def get_opclasses_are(cursor: TextIO, schema_name: str) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY_AGG( DISTINCT p.opcname ) AS opclasses_are
        FROM
            pg_catalog.pg_opclass AS p
            JOIN pg_catalog.pg_namespace AS n ON (
                n.oid = p.opcnamespace AND
                n.nspname = %s
            )
    """,
        (schema_name,),
    )
    records = cursor.fetchone()
    return records.opclasses_are


@log_function_call
def get_types_are(cursor: TextIO, schema_name: str) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY_AGG( DISTINCT pg_type.typname ) AS types_are
        FROM
            pg_catalog.pg_type
            JOIN pg_catalog.pg_namespace ON ( pg_namespace.oid = pg_type.typnamespace )
            LEFT JOIN pg_catalog.pg_class ON ( pg_class.oid = pg_type.typrelid )
        WHERE
            pg_type.typtype = ANY( ARRAY['b', 'c', 'd', 'p', 'e'] ) AND
            pg_namespace.nspname NOT IN ( 'information_schema', 'pg_catalog' ) AND
            (
                pg_class.relkind = 'c' OR
                pg_type.typrelid = 0
            ) AND
            NOT EXISTS(
                    SELECT 1 FROM pg_catalog.pg_type el WHERE el.oid = pg_type.typelem AND el.typarray = pg_type.oid
            ) AND
                pg_namespace.nspname = %s
    """,
        (schema_name,),
    )
    records = cursor.fetchone()
    return records.types_are


@log_function_call
def get_domains_are(cursor: TextIO, schema_name: str) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY_AGG( DISTINCT t.typname ) AS domains_are
        FROM
            pg_catalog.pg_type AS t
            JOIN pg_catalog.pg_namespace AS n ON (
                n.oid = t.typnamespace AND
                n.nspname = %s
            )
        WHERE
            t.typtype = 'd'
    """,
        (schema_name,),
    )
    records = cursor.fetchone()
    return records.domains_are


@log_function_call
def get_enums_are(cursor: TextIO, schema_name: str) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY_AGG( DISTINCT t.typname ) AS enums_are
        FROM
            pg_catalog.pg_type AS t
            JOIN pg_catalog.pg_namespace AS n ON (
                n.oid = t.typnamespace AND
                n.nspname = %s
            )
        WHERE
            t.typtype = 'e'
    """,
        (schema_name,),
    )
    records = cursor.fetchone()
    return records.enums_are


@log_function_call
def get_operators_are(cursor: TextIO, schema_name: str) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY_AGG(
                o.oprname || '(' ||
                pg_catalog.format_type(o.oprleft, NULL) || ',' ||
                pg_catalog.format_type(o.oprright, NULL) ||
                ') RETURNS ' || o.oprresult::regtype
            ) AS operators_are
        FROM
            pg_catalog.pg_operator o
            JOIN pg_catalog.pg_namespace n ON o.oprnamespace = n.oid
        WHERE
            n.nspname = %s
    """,
        (schema_name,),
    )
    records = cursor.fetchone()
    return records.operators_are


@log_function_call
def get_partitions_are(
    cursor: TextIO, schema_name: str, table_name: str, kind: str = "p"
) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY_AGG( n.nspname || '.' || c2.relname ) AS partitions_are
        FROM
            pg_class c1
            JOIN pg_catalog.pg_inherits i ON ( i.inhparent = c1.oid )
            JOIN pg_class c2 ON ( c2.oid = i.inhrelid )
            JOIN pg_namespace n ON ( n.oid = c1.relnamespace )
        WHERE
            c1.relkind = %s AND
            n.nspname = %s AND
            c1.relname = %s
    """,
        (kind, schema_name, table_name),
    )
    records = cursor.fetchone()
    return records.partitions_are


@log_function_call
def get_columns_are(cursor: TextIO, schema_name: str, table_name: str) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY_AGG( a.attname ) AS columns_are
        FROM
            pg_catalog.pg_namespace n
            JOIN pg_catalog.pg_class c ON  ( c.relnamespace = n.oid )
            JOIN pg_catalog.pg_attribute a ON ( a.attrelid = c.oid )
            JOIN pg_catalog.pg_type t ON ( t.oid = a.atttypid )
            JOIN pg_catalog.pg_namespace tn ON ( tn.oid = t.typnamespace )
            LEFT JOIN pg_attrdef ad ON (
                ad.adrelid = a.attrelid AND
                ad.adnum = a.attnum
            )
        WHERE
            n.nspname = %s AND
            c.relname = %s AND
            attnum > 0 AND
            NOT a.attisdropped
    """,
        (schema_name, table_name),
    )
    records = cursor.fetchone()
    return records.columns_are


@log_function_call
def get_indexes_are(cursor: TextIO, schema_name: str, table_name: str) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY_AGG( indexname ) AS indexes_are
        FROM
            pg_catalog.pg_indexes
        WHERE
            schemaname = %s AND
            tablename = %s
    """,
        (schema_name, table_name),
    )
    records = cursor.fetchone()
    return records.indexes_are


@log_function_call
def get_triggers_are(cursor: TextIO, schema_name: str, table_name: str) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY_AGG( pg_trigger.tgname ) AS triggers_are
        FROM
            pg_catalog.pg_class
            JOIN pg_catalog.pg_namespace ON ( pg_namespace.oid = pg_class.relnamespace )
            JOIN pg_catalog.pg_trigger ON ( pg_trigger.tgrelid = pg_class.oid )
        WHERE
            pg_namespace.nspname = %s AND
            pg_class.relname = %s AND
            pg_class.relhastriggers AND
            NOT pg_trigger.tgisinternal
    """,
        (schema_name, table_name),
    )
    records = cursor.fetchone()
    return records.triggers_are


@log_function_call
def get_rules_are(cursor: TextIO, schema_name: str, table_name: str) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY_AGG( pg_rules.rulename ) AS rules_are
        FROM
            pg_catalog.pg_rules
        WHERE
            pg_rules.schemaname = %s AND
            pg_rules.tablename = %s
    """,
        (schema_name, table_name),
    )
    records = cursor.fetchone()
    return records.rules_are


@log_function_call
def get_languages_info(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            l.lanname AS language_name,
            pg_get_userbyid( l.lanowner ) AS owner_is,
            l.lanpltrusted AS is_trusted
        FROM
            pg_catalog.pg_language AS l
    """
    )
    return cursor.fetchall()


@log_function_call
def get_tablespace_info(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            t.spcname AS tablespace_name,
            pg_get_userbyid( t.spcowner ) AS owner_is
        FROM
            pg_catalog.pg_tablespace AS t
    """
    )
    return cursor.fetchall()


@log_function_call
def get_role_info(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            r.rolname AS role_name,
            r.rolsuper AS is_superuser,
            r.rolinherit,
            r.rolcreaterole,
            r.rolcreatedb,
            CASE r.rolcanlogin
                WHEN True THEN 'user'
                WHEN False THEN 'group'
                ELSE 'role'
            END AS role_type,
            r.rolreplication,
            r.rolconnlimit,
            r.rolvaliduntil,
            r.rolbypassrls,
            r.rolconfig,
            ARRAY_AGG( mr.rolname ) AS members,
            NULL AS not_members
        FROM
            pg_catalog.pg_roles r
            LEFT JOIN pg_catalog.pg_auth_members AS m ON (m.roleid = r.oid)
            LEFT JOIN pg_catalog.pg_roles AS mr ON (mr.oid = m.member)
            LEFT JOIN (
                SELECT
                    roleid
                FROM
                    pg_catalog.pg_auth_members
                GROUP BY
                    roleid
                HAVING
                    COUNT(*) = 0
            ) AS nm ON r.oid = nm.roleid
        WHERE
            nm.roleid IS NOT NULL OR m.roleid IS NULL
        GROUP BY
            r.rolname,
            r.rolsuper,
            r.rolinherit,
            r.rolcreaterole,
            r.rolcreatedb,
            r.rolcanlogin,
            r.rolreplication,
            r.rolconnlimit,
            r.rolvaliduntil,
            r.rolbypassrls,
            r.rolconfig
    """
    )
    return cursor.fetchall()


@log_function_call
def get_extension_info(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            current_database() AS database_name,
            n.nspname AS schema_name,
            e.extname AS extension_name,
            pg_get_userbyid( e.extowner ) AS owner_is
        FROM
            pg_catalog.pg_extension AS e
            JOIN pg_catalog.pg_namespace AS n ON ( n.oid = e.extnamespace )
    """
    )
    return cursor.fetchall()


@log_function_call
def get_database_info(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            d.datname AS database_name,
            pg_get_userbyid( d.datdba ) AS owner_is
        FROM
            pg_catalog.pg_database AS d
        WHERE
            d.datname = current_database()
    """
    )
    return cursor.fetchall()


@log_function_call
def get_schema_info(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            current_database() AS database_name,
            n.nspname AS schema_name,
            pg_get_userbyid( n.nspowner ) AS owner_is
        FROM
            pg_catalog.pg_namespace AS n
        WHERE
            n.nspname NOT IN ( 'information_schema' ) AND
            n.nspname NOT ILIKE 'pg_%'
    """
    )
    return cursor.fetchall()


@log_function_call
def get_table_info(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            current_database() AS database_name,
            n.nspname AS schema_name,
            c.relname AS table_name,
            pg_get_userbyid( c.relowner ) AS owner_is,
            jsonb_build_object(
                'has_check', CASE WHEN 'c' = ANY(ARRAY_AGG(pc.contype)) THEN true ELSE false END,
                'has_fk', CASE WHEN 'f' = ANY(ARRAY_AGG(pc.contype)) THEN true ELSE false END,
                'has_pk', CASE WHEN 'p' = ANY(ARRAY_AGG(pc.contype)) THEN true ELSE false END,
                'has_unique', CASE WHEN 'u' = ANY(ARRAY_AGG(pc.contype)) THEN true ELSE false END,
                'has_trigger', CASE WHEN 't' = ANY(ARRAY_AGG(pc.contype)) THEN true ELSE false END,
                'has_exclusion', CASE WHEN 'x' = ANY(ARRAY_AGG(pc.contype)) THEN true ELSE false END
            ) AS has_constraints
        FROM
            pg_catalog.pg_class c
            JOIN pg_catalog.pg_namespace AS n ON (
                n.oid = c.relnamespace AND
                n.nspname NOT IN ( 'information_schema' ) AND
                n.nspname NOT ILIKE 'pg_%'
            )
            LEFT JOIN pg_catalog.pg_constraint AS pc ON ( pc.conrelid = c.oid )
        WHERE
            c.relkind IN ( 'p', 'r' )
        GROUP BY
            n.nspname,
            c.relname,
            pg_get_userbyid( c.relowner )
        ORDER BY
            n.nspname,
            c.relname
    """
    )
    return cursor.fetchall()


@log_function_call
def get_column_info(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            current_database() AS database_name,
            n.nspname AS schema_name,
            c.relname AS table_name,
            a.attname AS column_name,
            a.attnotnull AS is_nullable,
            a.atthasdef AS has_default,
            tn.nspname AS type_schema,
            pg_catalog.format_type(a.atttypid, a.atttypmod) AS dt_type,
            typname AS type_name,
            CASE
                WHEN a.attgenerated = ''::"char"
                    THEN pg_get_expr( ad.adbin, ad.adrelid )
                ELSE NULL::text
            END::information_schema.character_data AS column_default
        FROM
            pg_catalog.pg_namespace n
            JOIN pg_catalog.pg_class c ON  (
                c.relnamespace = n.oid AND
                c.relkind IN ( 'p', 'r' )
            )
            JOIN pg_catalog.pg_attribute a ON ( a.attrelid = c.oid )
            JOIN pg_catalog.pg_type t ON ( t.oid = a.atttypid )
            JOIN pg_catalog.pg_namespace tn ON ( tn.oid = t.typnamespace )
            LEFT JOIN pg_attrdef ad ON (
                ad.adrelid = a.attrelid AND
                ad.adnum = a.attnum
            )
        WHERE
            n.nspname NOT IN ( 'information_schema' ) AND
            n.nspname NOT ILIKE 'pg_%' AND
            attnum > 0 AND
            NOT a.attisdropped
        ORDER BY
            schema_name,
            table_name,
            a.attnum
    """
    )
    return cursor.fetchall()


@log_function_call
def get_con_columns_are(
    cursor: TextIO, schema_name: str, table_name: str, con_type: str
) -> List[str]:
    cursor.execute(
        """
        SELECT
            ARRAY(
                SELECT
                    a.attname
                FROM
                    pg_catalog.pg_attribute a
                    JOIN generate_series(1, array_upper(x.conkey, 1)) s(i) ON ( a.attnum = x.conkey[i] )
                WHERE
                    attrelid = x.conrelid
                ORDER BY i
            ) AS columns_are
        FROM
            pg_catalog.pg_namespace n
            JOIN pg_catalog.pg_class c ON ( c.relnamespace = n.oid )
            JOIN pg_catalog.pg_constraint x ON ( x.conrelid = c.oid )
        WHERE
            n.nspname = %s AND
            c.relname = %s AND
            x.contype = %s
        ORDER BY 1
    """,
        (schema_name, table_name, con_type),
    )
    return cursor.fetchall()


@log_function_call
def get_con_columns_arent(
    cursor: TextIO, schema_name: str, table_name: str, con_type: str
) -> List[str]:
    cursor.execute(
        """
        WITH pkc AS (
            SELECT
                a.attname
            FROM
                pg_catalog.pg_namespace AS n
                JOIN pg_catalog.pg_class AS c ON ( c.relnamespace = n.oid )
                JOIN pg_catalog.pg_constraint AS x ON ( x.conrelid = c.oid )
                JOIN pg_catalog.pg_attribute AS a ON (
                    a.attnum = ANY( x.conkey ) AND
                    a.attnum > 0
                )
            WHERE
                n.nspname = %s AND
                c.relname = %s AND
                x.contype = %s
        )
        SELECT
            ARRAY(
                SELECT
                    a.attname
                FROM
                    pg_catalog.pg_attribute AS a
                    LEFT JOIN pkc AS pk ON ( pk.attname = a.attname )
                WHERE
                    a.attrelid = (
                        SELECT
                            oid
                        FROM
                            pg_catalog.pg_class
                        WHERE
                            relnamespace = (
                                SELECT oid
                                FROM pg_catalog.pg_namespace
                                WHERE nspname = %s
                        ) AND
                        relname = %s
                    ) AND
                    pk.attname IS NULL AND
                    a.attnum > 0
            ) AS columns_are
    """,
        (schema_name, table_name, con_type, schema_name, table_name),
    )
    return cursor.fetchall()


@log_function_call
def get_table_family_tree(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        WITH RECURSIVE inheritance_chain AS (
            -- select the ancestor tuple
            SELECT
                i.inhparent AS ancestor_id,
                n2.nspname AS ancestor_schema,
                c2.relname AS ancestor_table,
                i.inhrelid AS descendent_id,
                n1.nspname AS descendent_schema,
                c1.relname AS descendent_table
            FROM
                pg_catalog.pg_inherits i
                JOIN pg_catalog.pg_class c1 ON i.inhrelid = c1.oid
                JOIN pg_catalog.pg_namespace n1 ON c1.relnamespace = n1.oid
                JOIN pg_catalog.pg_class c2 ON i.inhparent = c2.oid
                JOIN pg_catalog.pg_namespace n2 ON c2.relnamespace = n2.oid
            WHERE
                n2.nspname NOT IN ('information_schema') AND
                n2.nspname NOT ILIKE 'pg_%' AND
                c2.relkind IN ('p', 'r')
            UNION
            -- select the descendents
            SELECT
                i.inhparent AS ancestor_id,
                p.ancestor_schema,
                p.ancestor_table,
                i.inhrelid AS descendent_id,
                p.descendent_schema,
                p.descendent_table
            FROM
                pg_catalog.pg_inherits i
                JOIN inheritance_chain p ON p.descendent_id = i.inhparent
            WHERE
                i.inhrelid IN (
                    SELECT
                        c2.oid
                    FROM
                        pg_catalog.pg_class c2
                        JOIN pg_catalog.pg_namespace n2 ON c2.relnamespace = n2.oid
                    WHERE
                        n2.nspname NOT IN ('information_schema') AND
                        n2.nspname NOT ILIKE 'pg_%' AND
                        c2.relkind IN ('p', 'r')
                )
        )
        SELECT
            ancestor_schema,
            ancestor_table,
            descendent_schema,
            descendent_table
        FROM
            inheritance_chain
    """
    )
    return cursor.fetchall()


@log_function_call
def get_is_partition_of(cursor: TextIO, schema_name: str, table_name: str) -> List[str]:
    cursor.execute(
        """
        SELECT
            pn.nspname AS parent_schema,
            pc.relname AS parent_table
        FROM
            pg_catalog.pg_namespace cn
            JOIN pg_catalog.pg_class cc ON ( cc.relnamespace = cn.oid )
            JOIN pg_catalog.pg_inherits i ON ( i.inhrelid = cc.oid )
            JOIN pg_catalog.pg_class pc ON ( pc.oid = i.inhparent )
            JOIN pg_catalog.pg_namespace pn ON ( pn.oid = pc.relnamespace )
        WHERE
            pc.relkind = 'p' AND
            cn.nspname = %s AND
            cc.relname = %s
    """,
        (schema_name, table_name),
    )
    return cursor.fetchall()


@log_function_call
def get_index_info(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT DISTINCT
            current_database() AS database_name,
            n.nspname AS schema_name,
            ct.relname AS table_name,
            ci.relname AS index_name,
            am.amname AS index_type,
            pg_catalog.pg_get_userbyid( ci.relowner ) AS owner_is,
            x.indisunique AS is_unique,
            x.indisprimary AS is_primary,
            x.indisexclusion AS is_exclusion,
            x.indisclustered AS is_clustered,
            --ARRAY_TO_STRING(
                (
                    SELECT
                        ARRAY_AGG( ba.attname )
                    FROM
                        pg_catalog.pg_namespace bn
                        JOIN pg_catalog.pg_class bc ON ( bc.relnamespace = bn.oid )
                        JOIN pg_catalog.pg_attribute ba ON ( ba.attrelid = bc.oid )
                    WHERE
                        bn.nspname = n.nspname AND
                        bc.relname = ci.relname AND
                        ba.attnum > 0 AND
                        NOT ba.attisdropped AND
                        NOT EXISTS (SELECT 1 FROM pg_catalog.pg_proc AS bp WHERE bp.pronamespace = bn.oid AND bp.proname = ba.attname )
            --    ), ', '
            ) AS column_names,
            ARRAY_TO_STRING(
                ARRAY(
                    SELECT
                        pg_catalog.pg_get_indexdef( aci.oid, s.i + 1, false)
                    FROM
                        pg_catalog.pg_index ax
                        JOIN pg_catalog.pg_class act ON ( act.oid = ax.indrelid )
                        JOIN pg_catalog.pg_class aci ON ( aci.oid = ax.indexrelid )
                        JOIN pg_catalog.pg_namespace an ON ( an.oid = act.relnamespace )
                        JOIN generate_series(0, current_setting('max_index_keys')::int - 1) s(i) ON ( ax.indkey[s.i] IS NOT NULL )
                    WHERE
                        act.relname = ct.relname AND
                        aci.relname = ci.relname AND
                        an.nspname = n.nspname
                    ORDER BY s.i
                ), ', '
            ) AS index_columns
        FROM
            pg_catalog.pg_index x
            JOIN pg_catalog.pg_class ct ON ( ct.oid = x.indrelid )
            JOIN pg_catalog.pg_class ci ON ( ci.oid = x.indexrelid )
            JOIN pg_catalog.pg_namespace n ON ( n.oid = ct.relnamespace )
            JOIN generate_series(0, current_setting('max_index_keys')::int - 1) s(i) ON ( x.indkey[s.i] IS NOT NULL )
            JOIN pg_am am ON ( am.oid = ci.relam )
        WHERE
            n.nspname NOT IN ( 'information_schema' ) AND
            n.nspname NOT ILIKE 'pg_%'
    """
    )
    rows = cursor.fetchall()
    return rows


@log_function_call
def get_rule_info(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            current_database() AS database_name,
            n.nspname AS schema_name,
            c.relname AS table_name,
            r.rulename AS rule_name,
            CASE r.ev_type
                WHEN '1' THEN 'SELECT'
                WHEN '2' THEN 'UPDATE'
                WHEN '3' THEN 'INSERT'
                WHEN '4' THEN 'DELETE'
                ELSE 'UNKNOWN'
            END AS dml_type,
            r.is_instead
        FROM
            pg_catalog.pg_rewrite r
            JOIN pg_catalog.pg_class c ON ( c.oid = r.ev_class )
            JOIN pg_catalog.pg_namespace n ON ( n.oid = c.relnamespace )
        WHERE
            n.nspname NOT IN ( 'information_schema' ) AND
            n.nspname NOT ILIKE 'pg_%' AND
            r.rulename != '_RETURN'
        ORDER BY
          n.nspname,
          c.relname,
          r.rulename
    """
    )
    return cursor.fetchall()


@log_function_call
def get_foreign_key_info(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            current_database() AS database_name,
            n1.nspname AS fk_schema,
            c1.relname AS fk_table,
            k1.conname AS fk_name,
            string_to_array(string_agg(DISTINCT a.attname, ','), ',') AS fk_columns,
            n2.nspname AS pk_schema,
            c2.relname AS pk_table,
            string_to_array(string_agg(DISTINCT b.attname, ','), ',') AS pk_columns
        FROM
            pg_constraint k1
            JOIN pg_namespace n1 ON (n1.oid = k1.connamespace)
            JOIN pg_class c1 ON (c1.oid = k1.conrelid)
            JOIN pg_class c2 ON (c2.oid = k1.confrelid)
            JOIN pg_namespace n2 ON (n2.oid = c2.relnamespace)
            JOIN pg_depend d ON (
                d.classid = 'pg_constraint'::regclass::oid AND
                d.objid = k1.oid AND
                d.objsubid = 0 AND
                d.deptype = 'n'::"char" AND
                d.refclassid = 'pg_class'::regclass::oid AND
                d.refobjsubid = 0
            )
            JOIN pg_class ci ON (
                ci.oid = d.refobjid AND
                ci.relkind = 'i'::"char"
            )
            LEFT JOIN pg_depend d2 ON (
                d2.classid = 'pg_class'::regclass::oid AND
                d2.objid = ci.oid AND
                d2.objsubid = 0 AND
                d2.deptype = 'i'::"char" AND
                d2.refclassid = 'pg_constraint'::regclass::oid AND
                d2.refobjsubid = 0
            )
            LEFT JOIN pg_constraint k2 ON (
                k2.oid = d2.refobjid AND
                (k2.contype = ANY (ARRAY['p'::"char", 'u'::"char"]))
            )
            LEFT JOIN pg_attribute a ON (
                a.attnum = ANY (k1.conkey) AND
                a.attrelid = k1.conrelid
            )
            LEFT JOIN pg_attribute b ON (
                b.attnum = ANY (k1.confkey) AND
                b.attrelid = k1.confrelid
            )
        WHERE
            k1.conrelid <> 0::oid AND
            k1.confrelid <> 0::oid AND
            k1.contype = 'f'::"char" AND
            n1.nspname NOT IN ( 'information_schema' ) AND
            n1.nspname NOT ILIKE 'pg_%'
        GROUP BY
            current_database(),
            n1.nspname,
            c1.relname,
            k1.conname,
            n2.nspname,
            c2.relname
    """
    )
    return cursor.fetchall()


@log_function_call
def get_trigger_info(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            current_database() AS database_name,
            nt.nspname AS trg_schema,
            ct.relname AS trg_table,
            ni.nspname AS trg_function_schema,
            p.proname  AS trg_function,
            t.tgname AS trg_name
        FROM
            pg_catalog.pg_trigger t
            JOIN pg_catalog.pg_class ct ON ( ct.oid = t.tgrelid )
            JOIN pg_catalog.pg_namespace nt ON ( nt.oid = ct.relnamespace )
            JOIN pg_catalog.pg_proc p ON ( p.oid = t.tgfoid )
            JOIN pg_catalog.pg_namespace ni ON ( ni.oid = p.pronamespace )
        WHERE
            NOT t.tgisinternal AND
            nt.nspname NOT IN ( 'information_schema' ) AND
            nt.nspname NOT ILIKE 'pg_%'
        ORDER BY
            current_database(),
            nt.nspname,
            ct.relname,
            t.tgname,
            ni.nspname,
            p.proname
    """
    )
    return cursor.fetchall()


@log_function_call
def get_sequence_info(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            current_database() AS database_name,
            schemaname AS seq_schema,
            sequencename AS seq_name,
            sequenceowner AS seq_owner,
            data_type AS seq_dt,
            max_value AS seq_max,
            last_value AS seq_last
        FROM
            pg_catalog.pg_sequences
    """
    )
    return cursor.fetchall()


@log_function_call
def get_view_info(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            current_database() AS database_name,
            view_schema,
            view_name,
            view_owner,
            jsonb_agg(DISTINCT table_info) AS table_info
        FROM (
            SELECT DISTINCT
                vn.nspname AS view_schema,
                vc.relname AS view_name,
                pg_get_userbyid(vc.relowner) AS view_owner,
                jsonb_build_object(
                    'table_schema'::TEXT, cast(tn.nspname AS TEXT),
                    'table_name'::TEXT, cast(tc.relname as text)
                ) AS table_info
            FROM
                pg_catalog.pg_rewrite AS r
                JOIN pg_catalog.pg_class AS vc ON (vc.oid = r.ev_class and vc.relkind IN ('v'))
                JOIN pg_catalog.pg_namespace AS vn ON (
                    vn.oid = vc.relnamespace AND
                    vn.nspname NOT IN ('information_schema') AND
                    vn.nspname NOT ILIKE 'pg_%'
                )
                JOIN pg_catalog.pg_depend AS d ON (r.oid = d.objid)
                JOIN pg_catalog.pg_class AS tc ON (tc.oid = d.refobjid AND tc.relname != vc.relname) -- Prevents tap_funky from being included.
                JOIN pg_catalog.pg_namespace AS tn ON (
                    tn.oid = tc.relnamespace AND
                    tn.nspname NOT IN ('information_schema') AND
                    tn.nspname NOT ILIKE 'pg_%'
                )
        ) AS subquery
        GROUP BY
            current_database(),
            view_schema,
            view_name,
            view_owner
    """
    )
    return cursor.fetchall()


@log_function_call
def get_materialized_view_info(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            current_database() AS database_name,
            n.nspname AS mtv_schema,
            c.relname AS mtv_name,
            pg_get_userbyid( c.relowner ) AS mtv_owner
        FROM pg_class AS c
            LEFT JOIN pg_namespace AS n ON ( n.oid = c.relnamespace )
            LEFT JOIN pg_tablespace AS t ON ( t.oid = c.reltablespace )
        WHERE
            c.relkind = 'm'
    """
    )
    return cursor.fetchall()


@log_function_call
def get_foreign_table_info(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            current_database() AS database_name,
            n.nspname AS ft_schema,
            c.relname AS ft_name,
            pg_get_userbyid( c.relowner ) AS ft_owner
        FROM
            pg_catalog.pg_class AS c
            JOIN pg_catalog.pg_namespace AS n ON (
                n.oid = c.relnamespace AND
                n.nspname NOT IN ( 'information_schema' ) AND
                n.nspname NOT ILIKE 'pg_%'
            )
        WHERE
            c.relkind = 'f'
    """
    )
    return cursor.fetchall()


@log_function_call
def get_data_type_info(cursor: TextIO, kinds: List[str] = None) -> List[str]:
    validate_kinds("pg_type", kinds)
    cursor.execute(
        """
        SELECT
            current_database() AS database_name,
            n.nspname AS typ_schema,
            t.typname AS typ_name,
            pg_get_userbyid( t.typowner ) AS typ_owner,
            dn.nspname AS dt_schema,
            pg_catalog.format_type( dt.oid, dt.typtypmod ) AS dt_name,
            ARRAY_AGG( e.enumlabel ORDER BY e.enumsortorder ) AS typ_enum_label
        FROM
            pg_catalog.pg_type AS t
            JOIN pg_catalog.pg_namespace AS n ON (
                n.oid = t.typnamespace AND
                n.nspname NOT IN ( 'information_schema' ) AND
                n.nspname NOT ILIKE 'pg_%%'
            )
            LEFT JOIN pg_catalog.pg_enum AS e ON ( e.enumtypid = t.oid )
            LEFT JOIN pg_catalog.pg_type AS dt ON ( dt.oid = t.typbasetype )
            LEFT JOIN pg_catalog.pg_namespace AS dn ON ( dn.oid = dt.typnamespace )
        WHERE
            t.typtype = ANY( %s )
        GROUP BY
            current_database(),
            n.nspname,
            t.typname,
            pg_get_userbyid( t.typowner ),
            dn.nspname,
            dt.oid
    """,
        [kinds],
    )
    return cursor.fetchall()


@log_function_call
def get_enum_info(cursor: TextIO) -> List[str]:
    return get_data_type_info(cursor, kinds=["e"])


@log_function_call
def get_domain_info(cursor: TextIO) -> List[str]:
    return get_data_type_info(cursor, ["d"])


@log_function_call
def get_function_info(cursor: TextIO) -> List[str]:
    cursor.execute(
        """
        SELECT
            current_database() AS database_name,
            proc_oid,
            pro_schema,
            pro_name,
            pro_owner,
            pro_lang,
            is_strict,
            is_definer,
            volatility,
            is_visible,
            pro_kind,
            pro_returns,
            STRING_TO_ARRAY( STRING_AGG( FORMAT_TYPE( a.elem, NULL ), ',' ), ',' ) AS pro_args,
            COALESCE( pro_name || '(' || REGEXP_REPLACE( REGEXP_REPLACE( STRING_AGG( FORMAT_TYPE( a.elem, NULL ), ',' ), ',', '_', 'g' ), ' ', '_', 'g' ) || ')', '()' ) AS pro_signature
        FROM (
            SELECT
                p.oid AS proc_oid,
                n.nspname AS pro_schema,
                p.proname AS pro_name,
                pg_get_userbyid( p.proowner ) AS pro_owner,
                l.lanname AS pro_lang,
                p.proisstrict AS is_strict,
                p.prosecdef AS is_definer,
                p.proretset AS returns_set,
                p.provolatile::character(1) AS volatility,
                pg_function_is_visible(p.oid) AS is_visible,
                p.prokind AS pro_kind,
                a.nr,
                a.elem,
                CASE p.proretset
                    WHEN true THEN 'setof '::text
                    ELSE ''::text
                END || p.prorettype::regtype AS pro_returns
            FROM
                pg_catalog.pg_proc AS p
                LEFT JOIN LATERAL UNNEST( p.proargtypes ) WITH ORDINALITY AS a(elem, nr) ON true
                JOIN pg_catalog.pg_namespace AS n ON ( n.oid = p.pronamespace )
                JOIN pg_catalog.pg_language AS l ON ( l.oid = p.prolang )
            WHERE
                n.nspname NOT IN ( 'information_schema' ) AND
                n.nspname NOT ILIKE 'pg_%'
            ORDER BY
                proc_oid,
                nr
        ) AS a
        GROUP BY
            current_database(),
            proc_oid,
            pro_schema,
            pro_name,
            pro_owner,
            pro_lang,
            is_strict,
            is_definer,
            volatility,
            is_visible,
            pro_kind,
            pro_returns
    """
    )
    return cursor.fetchall()


@log_function_call(log_level=logging.INFO, info_message="TODO: Implementation pending!")
def get_acl_info(cursor: TextIO) -> List[str]:
    return
    cursor.execute(
        """
    """
    )
    return cursor.fetchall()
