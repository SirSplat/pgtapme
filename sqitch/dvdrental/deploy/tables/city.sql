-- Deploy db_design_intro:tables/city to pg
-- requires: appschema
-- requires: tables/country
-- requires: sequences/city_city_id_seq

BEGIN;

CREATE TABLE rental.city (
    city_id integer DEFAULT nextval('rental.city_city_id_seq'::regclass) NOT NULL,
    city character varying(50) NOT NULL,
    country_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);

COMMIT;
