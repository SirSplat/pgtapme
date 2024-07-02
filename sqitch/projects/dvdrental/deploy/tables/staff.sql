-- Deploy db_design_intro:tables/staff to pg
-- requires: appschema
-- requires: sequences/staff_staff_id_seq

BEGIN;

CREATE TABLE rental.staff (
    staff_id integer DEFAULT nextval('rental.staff_staff_id_seq'::regclass) NOT NULL,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    address_id smallint NOT NULL,
    email character varying(50),
    store_id smallint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    username character varying(16) NOT NULL,
    password character varying(40),
    last_update timestamp without time zone DEFAULT now() NOT NULL,
    picture bytea
);

COMMIT;
