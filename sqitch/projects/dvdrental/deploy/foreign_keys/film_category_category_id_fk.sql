-- Deploy db_design_intro:foreign_keys/film_category_category_id_fk to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.film_category
    ADD CONSTRAINT film_category_category_id_fk FOREIGN KEY (category_id) REFERENCES rental.category(category_id) ON UPDATE CASCADE ON DELETE RESTRICT;

COMMIT;
