-- Deploy db_design_intro:tables/category to pg
-- requires: appschema
-- requires: sequences/category_category_id_seq

BEGIN;

CREATE TABLE rental.category (
    category_id integer DEFAULT nextval('rental.category_category_id_seq'::regclass) NOT NULL,
    name character varying(25) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);

COMMIT;
