-- Deploy db_design_intro:triggers/inventory_last_updated_trg to pg
-- requires: db_design_intro:@v0.1-relations

BEGIN;

CREATE OR REPLACE TRIGGER last_updated_trg BEFORE UPDATE ON rental.inventory FOR EACH ROW EXECUTE PROCEDURE rental.last_updated_trg_func();

COMMIT;