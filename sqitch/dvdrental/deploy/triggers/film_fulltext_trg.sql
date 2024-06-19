-- Deploy db_design_intro:triggers/film_fulltext_trg to pg
-- requires: db_design_intro:@v0.1-relations

BEGIN;

CREATE OR REPLACE TRIGGER fulltext_trg
    BEFORE INSERT OR UPDATE
    ON rental.film
    FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger('fulltext', 'pg_catalog.english', 'title', 'description');

COMMIT;
