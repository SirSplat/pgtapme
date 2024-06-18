-- Deploy db_design_intro:indexes/category_pk to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.category
    ADD CONSTRAINT category_pk PRIMARY KEY (category_id);

COMMIT;
