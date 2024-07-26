-- Deploy pgtapme_dev:functions/d_date_inherit_trigger to pg
-- requires: appschema
-- requires: tables/d_date_inherit
-- requires: functions/d_date_inherit_create_trigger_function

BEGIN;

CREATE TRIGGER d_date_inherit_trg
  BEFORE INSERT OR DELETE OR UPDATE ON pgtapme.d_date_inherit
  FOR EACH ROW EXECUTE FUNCTION pgtapme.d_date_inherit_trg_func();

COMMIT;
