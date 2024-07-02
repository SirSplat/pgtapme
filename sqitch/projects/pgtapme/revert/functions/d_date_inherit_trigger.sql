-- Revert pgtapme_dev:functions/d_date_inherit_trigger from pg

BEGIN;

DROP TRIGGER d_date_inherit_trg ON pgtapme.d_date_inherit;

COMMIT;
