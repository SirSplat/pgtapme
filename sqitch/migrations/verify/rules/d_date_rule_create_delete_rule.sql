-- Verify pgtapme_dev:rules/d_date_rule_create_delete_rule on pg

BEGIN;

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m01_del_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m02_del_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m03_del_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m04_del_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m05_del_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m06_del_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m07_del_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m08_del_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m09_del_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m10_del_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m11_del_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m12_del_rule';

ROLLBACK;
