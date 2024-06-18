-- Revert db_design_intro:views/sales_by_film_category from pg

BEGIN;

DROP VIEW rental.sales_by_film_category;

COMMIT;
