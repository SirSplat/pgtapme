-- Deploy db_design_intro:indexes/film_title_idx to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

CREATE INDEX film_title_idx ON rental.film(title);

COMMIT;
