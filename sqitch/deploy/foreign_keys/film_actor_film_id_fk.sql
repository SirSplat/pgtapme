-- Deploy db_design_intro:foreign_keys/film_actor_film_id_fk to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.film_actor
    ADD CONSTRAINT film_actor_film_id_fk FOREIGN KEY (film_id) REFERENCES rental.film(film_id) ON UPDATE CASCADE ON DELETE RESTRICT;

COMMIT;
