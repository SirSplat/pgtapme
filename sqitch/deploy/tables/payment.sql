-- Deploy db_design_intro:tables/payment to pg
-- requires: appschema
-- requires: sequences/payment_payment_id_seq

BEGIN;

CREATE TABLE rental.payment (
    payment_id integer DEFAULT nextval('rental.payment_payment_id_seq'::regclass) NOT NULL,
    customer_id smallint NOT NULL,
    staff_id smallint NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp without time zone NOT NULL
);

COMMIT;
