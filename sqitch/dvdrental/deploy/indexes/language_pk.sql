-- Deploy db_design_intro:indexes/language_pk to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.language
    ADD CONSTRAINT language_pk PRIMARY KEY (language_id);

COMMIT;
