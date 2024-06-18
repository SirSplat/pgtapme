-- Deploy db_design_intro:tables/actor to pg
-- requires: appschema
-- requires: sequences/actor_actor_id_seq

BEGIN;

CREATE TABLE rental.actor (
    actor_id integer DEFAULT nextval('rental.actor_actor_id_seq'::regclass) NOT NULL,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);

COMMIT;
