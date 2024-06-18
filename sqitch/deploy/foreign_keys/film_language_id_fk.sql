-- Deploy db_design_intro:foreign_keys/film_language_id_fk to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.film
    ADD CONSTRAINT film_language_id_fk FOREIGN KEY (language_id) REFERENCES rental.language(language_id) ON UPDATE CASCADE ON DELETE RESTRICT;

COMMIT;
