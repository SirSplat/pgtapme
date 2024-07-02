-- Deploy db_design_intro:tables/language to pg
-- requires: appschema
-- requires: sequences/language_language_id_seq

BEGIN;

CREATE TABLE rental.language (
    language_id integer DEFAULT nextval('rental.language_language_id_seq'::regclass) NOT NULL,
    name character(20) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);

COMMIT;
