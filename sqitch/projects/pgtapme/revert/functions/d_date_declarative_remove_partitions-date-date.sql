-- Revert pgtapme_dev:functions/d_date_declarative_remove_partitions from pg

BEGIN;

DROP FUNCTION pgtapme.d_date_declarative_remove_partitions( date, date );

COMMIT;
