-- Deploy db_design_intro:triggers/film_actor_last_updated_trg to pg
-- requires: db_design_intro:@v0.1-relations

BEGIN;

CREATE OR REPLACE TRIGGER last_updated_trg BEFORE UPDATE ON rental.film_actor FOR EACH ROW EXECUTE PROCEDURE rental.last_updated_trg_func();

COMMIT;
