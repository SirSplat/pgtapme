-- Deploy db_design_intro:triggers/city_last_updated_trg to pg
-- requires: db_design_intro:@v0.1-relations

BEGIN;

CREATE OR REPLACE TRIGGER last_updated_trg BEFORE UPDATE ON rental.city FOR EACH ROW EXECUTE PROCEDURE rental.last_updated_trg_func();

COMMIT;
