-- Revert db_design_intro:views/nicer_but_slower_film_list from pg

BEGIN;

DROP VIEW rental.nicer_but_slower_film_list;

COMMIT;
