-- Deploy db_design_intro:foreign_keys/film_actor_actor_id_fk to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.film_actor
    ADD CONSTRAINT film_actor_actor_id_fk FOREIGN KEY (actor_id) REFERENCES rental.actor(actor_id) ON UPDATE CASCADE ON DELETE RESTRICT;

COMMIT;
