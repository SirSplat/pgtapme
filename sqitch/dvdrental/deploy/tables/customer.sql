-- Deploy db_design_intro:tables/customer to pg
-- requires: appschema
-- requires: sequences/customer_customer_id_seq

BEGIN;

CREATE TABLE rental.customer (
    customer_id integer DEFAULT nextval('rental.customer_customer_id_seq'::regclass) NOT NULL,
    store_id smallint NOT NULL,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    email character varying(50),
    address_id smallint NOT NULL,
    activebool boolean DEFAULT true NOT NULL,
    create_date date DEFAULT ('now'::text)::date NOT NULL,
    last_update timestamp without time zone DEFAULT now(),
    active integer
);

COMMIT;
