-- Deploy db_design_intro:sequences/country_country_id_seq to pg
-- requires: appschema

BEGIN;

CREATE SEQUENCE rental.country_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

COMMIT;
