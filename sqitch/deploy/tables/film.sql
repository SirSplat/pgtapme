-- Deploy db_design_intro:tables/film to pg
-- requires: appschema
-- requires: sequences/film_film_id_seq

BEGIN;

CREATE TABLE rental.film (
    film_id integer DEFAULT nextval('rental.film_film_id_seq'::regclass) NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    release_year rental.year,
    language_id smallint NOT NULL,
    rental_duration smallint DEFAULT 3 NOT NULL,
    rental_rate numeric(4,2) DEFAULT 4.99 NOT NULL,
    length smallint,
    replacement_cost numeric(5,2) DEFAULT 19.99 NOT NULL,
    rating rental.mpaa_rating DEFAULT 'G'::rental.mpaa_rating,
    last_update timestamp without time zone DEFAULT now() NOT NULL,
    special_features text[],
    fulltext tsvector NOT NULL
);

COMMIT;
