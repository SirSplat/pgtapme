-- Verify pgtapme_dev:rules/d_date_rule_create_update_rule on pg

BEGIN;

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m01_upd_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m02_upd_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m03_upd_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m04_upd_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m05_upd_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m06_upd_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m07_upd_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m08_upd_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m09_upd_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m10_upd_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m11_upd_rule';

SELECT
    1 / COUNT( pg_rules.rulename )
FROM
    pg_catalog.pg_rules
WHERE
    pg_rules.schemaname = 'pgtapme' AND
    pg_rules.tablename = 'd_date_rule' AND
    pg_rules.rulename = 'd_date_rule_y0001_m12_upd_rule';

ROLLBACK;
