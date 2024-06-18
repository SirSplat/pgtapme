-- Deploy db_design_intro:indexes/film_fulltext_idx to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

CREATE INDEX film_fulltext_idx ON rental.film USING gist (fulltext);

COMMIT;
