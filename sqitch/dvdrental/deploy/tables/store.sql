-- Deploy db_design_intro:tables/store to pg
-- requires: appschema
-- requires: sequences/store_store_id_seq

BEGIN;

CREATE TABLE rental.store (
    store_id integer DEFAULT nextval('rental.store_store_id_seq'::regclass) NOT NULL,
    manager_staff_id smallint NOT NULL,
    address_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);

COMMIT;
