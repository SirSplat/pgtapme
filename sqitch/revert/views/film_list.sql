-- Revert db_design_intro:views/film_list from pg

BEGIN;

DROP VIEW rental.film_list;

COMMIT;
