# pgtapme

PGTapMe

PGtapme is a tool for generating pgTap tests for PostgreSQL databases. It provides a modular and extensible framework to create tests for different aspects of your database schema.
Configuration

Before using PGtapme, you need to configure the database connection and set up the types of tests you want to generate. Edit the .env file to include your database connection details and specify the test types you are interested in.

DATABASE_NAME = dvdrental
DATABASE_USER = dbo
DATABASE_USER_PASSWORD = mysecretpassword
DATABASE_HOST = localhost
DATABASE_PORT = 5432

Usage

To run PGtapme, execute the pgtapme.py script. This script reads the configurations from config.json and the .env files then generates PGTap tests for the specified test types.

bash

python pgtapme.py

Test Types
Cluster Tests

The cluster tests focus on various aspects of the PostgreSQL cluster, including tablespaces, roles, groups, users, languages, casts, and extensions.
Directory Tree

csharp

.
└── cluster
    ├── cluster.sql
    ├── languages
    │   ├── c.sql
    │   ├── internal.sql
    │   ├── plpgsql.sql
    │   └── sql.sql

Sample Test: cluster/cluster.sql

sql

BEGIN;
  SELECT plan(6);

  SELECT tablespaces_are(ARRAY['pg_default', 'pg_global']::text[], 'Cluster should have the correct tablespaces.');

  SELECT roles_are(ARRAY['pg_database_owner', 'pg_read_all_data', 'pg_write_all_data', 'pg_monitor', 'pg_read_all_settings', 'pg_read_all_stats', 'pg_stat_scan_tables', 'pg_read_server_files', 'pg_write_server_files', 'pg_execute_server_program', 'pg_signal_backend', 'pg_checkpoint', 'postgres', 'dbo', 'dwh_etl', 'datadog']::text[], 'Cluster should have the correct roles.');

  SELECT groups_are(ARRAY['pg_database_owner', 'pg_read_all_data', 'pg_write_all_data', 'pg_monitor', 'pg_read_all_settings', 'pg_read_all_stats', 'pg_stat_scan_tables', 'pg_read_server_files', 'pg_write_server_files', 'pg_execute_server_program', 'pg_signal_backend', 'pg_checkpoint']::text[], 'Cluster should have the correct groups.');

  SELECT users_are(ARRAY['postgres', 'dbo', 'dwh_etl', 'datadog']::text[], 'Cluster should have the correct users.');

  SELECT languages_are(ARRAY['plpgsql']::text[], 'Cluster should have the correct languages.');

  SELECT casts_are(ARRAY['bigint AS smallint', 'bigint AS integer', 'bigint AS real', 'bigint AS double precision', 'bigint AS numeric', 'smallint AS bigint', 'smallint AS integer', 'smallint AS real', 'smallint AS double precision', 'smallint AS numeric', 'integer AS bigint', 'integer AS smallint', 'integer AS real', 'integer AS double precision', 'integer AS numeric', 'real AS bigint', 'real AS smallint', 'real AS integer', 'real AS double precision', 'real AS numeric', 'double precision AS bigint', 'double precision AS smallint', 'double precision AS integer', 'double precision AS real', 'double precision AS numeric', 'numeric AS bigint', 'numeric AS smallint', 'numeric AS integer', 'numeric AS real', 'numeric AS double precision', 'money AS numeric', 'numeric AS money', 'integer AS money', 'bigint AS money', 'integer AS boolean', 'boolean AS integer', 'xid8 AS xid', 'bigint AS oid', 'smallint AS oid', 'integer AS oid', 'oid AS bigint', 'oid AS integer', 'oid AS regproc', 'regproc AS oid', 'bigint AS regproc', 'smallint AS regproc', 'integer AS regproc', 'regproc AS bigint', 'regproc AS integer', 'regproc AS regprocedure', 'regprocedure AS regproc', 'oid AS regprocedure', 'regprocedure AS oid', 'bigint AS regprocedure', 'smallint AS regprocedure', 'integer AS regprocedure', 'regprocedure AS bigint', 'regprocedure AS integer', 'oid AS regoper', 'regoper AS oid', 'bigint AS regoper', 'smallint AS regoper', 'integer AS regoper', 'regoper AS bigint', 'regoper AS integer', 'regoper AS regoperator', 'regoperator AS regoper', 'oid AS regoperator', 'regoperator AS oid', 'bigint AS regoperator', 'smallint AS regoperator', 'integer AS regoperator', 'regoperator AS bigint', 'regoperator AS integer', 'oid AS regclass', 'regclass AS oid', 'bigint AS regclass', 'smallint AS regclass', 'integer AS regclass', 'regclass AS bigint', 'regclass AS integer', 'oid AS regcollation', 'regcollation AS oid', 'bigint AS regcollation', 'smallint AS regcollation', 'integer AS regcollation', 'regcollation AS bigint', 'regcollation AS integer', 'oid AS regtype', 'regtype AS oid', 'bigint AS regtype', 'smallint AS regtype', 'integer AS regtype', 'regtype AS bigint', 'regtype AS integer', 'oid AS regconfig', 'regconfig AS oid', 'bigint AS regconfig', 'smallint AS regconfig', 'integer AS regconfig', 'regconfig AS bigint', 'regconfig AS integer', 'oid AS regdictionary', 'regdictionary AS oid', 'bigint AS regdictionary', 'smallint AS regdictionary', 'integer AS regdictionary', 'regdictionary AS bigint', 'regdictionary AS integer', 'text AS regclass', 'character varying AS regclass', 'oid AS regrole', 'regrole AS oid', 'bigint AS regrole', 'smallint AS regrole', 'integer AS regrole', 'regrole AS bigint', 'regrole AS integer', 'oid AS regnamespace', 'regnamespace AS oid', 'bigint AS regnamespace', 'smallint AS regnamespace', 'integer AS regnamespace', 'regnamespace AS bigint', 'regnamespace AS integer', 'text AS character', 'text AS character varying', 'character AS text', 'character AS character varying', 'character varying AS text', 'character varying AS character', '"char" AS text', '"char" AS character', '"char" AS character varying', 'name AS text', 'name AS character', 'name AS character varying', 'text AS "char"', 'character AS "char"', 'character varying AS "char"', 'text AS name', 'character AS name', 'character varying AS name', '"char" AS integer', 'integer AS "char"', 'pg_node_tree AS text', 'pg_ndistinct AS bytea', 'pg_ndistinct AS text', 'pg_dependencies AS bytea', 'pg_dependencies AS text', 'pg_mcv_list AS bytea', 'pg_mcv_list AS text', 'date AS timestamp without time zone', 'date AS timestamp with time zone', 'time without time zone AS interval', 'time without time zone AS time with time zone', 'timestamp without time zone AS date', 'timestamp without time zone AS time without time zone', 'timestamp without time zone AS timestamp with time zone', 'timestamp with time zone AS date', 'timestamp with time zone AS time without time zone', 'timestamp with time zone AS timestamp without time zone', 'timestamp with time zone AS time with time zone', 'interval AS time without time zone', 'time with time zone AS time without time zone', 'point AS box', 'lseg AS point', 'path AS polygon', 'box AS point', 'box AS lseg', 'box AS polygon', 'box AS circle', 'polygon AS point', 'polygon AS path', 'polygon AS box', 'polygon AS circle', 'circle AS point', 'circle AS box', 'circle AS polygon', 'macaddr AS macaddr8', 'macaddr8 AS macaddr', 'cidr AS inet', 'inet AS cidr', 'bit AS bit varying', 'bit varying AS bit', 'bigint AS bit', 'integer AS bit', 'bit AS bigint', 'bit AS integer', 'cidr AS text', 'inet AS text', 'boolean AS text', 'xml AS text', 'text AS xml', 'cidr AS character varying', 'inet AS character varying', 'boolean AS character varying', 'xml AS character varying', 'character varying AS xml', 'cidr AS character', 'inet AS character', 'boolean AS character', 'xml AS character', 'character AS xml', 'character AS character', 'character varying AS character varying', 'time without time zone AS time without time zone', 'timestamp without time zone AS timestamp without time zone', 'timestamp with time zone AS timestamp with time zone', 'interval AS interval', 'time with time zone AS time with time zone', 'bit AS bit', 'bit varying AS bit varying', 'numeric AS numeric', 'json AS jsonb', 'jsonb AS json', 'jsonb AS boolean', 'jsonb AS numeric', 'jsonb AS smallint', 'jsonb AS integer', 'jsonb AS bigint', 'jsonb AS real', 'jsonb AS double precision', 'int4range AS int4multirange', 'int8range AS int8multirange', 'numrange AS nummultirange', 'daterange AS datemultirange', 'tsrange AS tsmultirange', 'tstzrange AS tstzmultirange']::text[], 'Cluster should have the correct casts.');

  SELECT * FROM finish();
ROLLBACK;

License

This project is licensed under the MIT License.











[target "pgtapme"]
	uri = db:pg://dbo:mysecretpassword@db:5432/pgtapme