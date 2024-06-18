-- Deploy db_design_intro:tables/film_actor to pg
-- requires: appschema
-- requires: tables/film
-- requires: tables/actor

BEGIN;

CREATE TABLE rental.film_actor (
    actor_id smallint NOT NULL,
    film_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);

COMMIT;
