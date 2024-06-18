-- Deploy db_design_intro:tables/address to pg
-- requires: appschema

BEGIN;

CREATE TABLE rental.address (
    address_id integer DEFAULT nextval('rental.address_address_id_seq'::regclass) NOT NULL,
    address character varying(50) NOT NULL,
    address2 character varying(50),
    district character varying(20) NOT NULL,
    city_id smallint NOT NULL,
    postal_code character varying(10),
    phone character varying(20) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);

COMMIT;
