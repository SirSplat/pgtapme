-- Deploy db_design_intro:indexes/film_language_id_idx to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

CREATE INDEX film_language_id_idx ON rental.film(language_id);

COMMIT;
