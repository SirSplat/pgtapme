-- Deploy db_design_intro:tables/inventory to pg
-- requires: appschema
-- requires: sequences/inventory_inventory_id_seq

BEGIN;

CREATE TABLE rental.inventory (
    inventory_id integer DEFAULT nextval('rental.inventory_inventory_id_seq'::regclass) NOT NULL,
    film_id smallint NOT NULL,
    store_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);

COMMIT;
