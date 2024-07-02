-- Verify pgtapme_dev:rules/d_date_rule_create_insert_rule on pg

BEGIN;

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m01_ins_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m02_ins_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m03_ins_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m04_ins_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m05_ins_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m06_ins_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m07_ins_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m08_ins_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m09_ins_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m10_ins_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m11_ins_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m12_ins_rule';

ROLLBACK;
