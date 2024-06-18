-- Deploy db_design_intro:tables/rental to pg
-- requires: appschema
-- requires: sequences/rental_rental_id_seq

BEGIN;

CREATE TABLE rental.rental (
    rental_id integer DEFAULT nextval('rental.rental_rental_id_seq'::regclass) NOT NULL,
    rental_date timestamp without time zone NOT NULL,
    inventory_id integer NOT NULL,
    customer_id smallint NOT NULL,
    return_date timestamp without time zone,
    staff_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);

COMMIT;
