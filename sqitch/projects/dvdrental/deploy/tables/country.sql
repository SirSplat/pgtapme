-- Deploy db_design_intro:tables/country to pg
-- requires: appschema
-- requires: sequences/country_country_id_seq

BEGIN;

CREATE TABLE rental.country (
    country_id integer DEFAULT nextval('rental.country_country_id_seq'::regclass) NOT NULL,
    country character varying(50) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);

COMMIT;
