-- Revert db_design_intro:data/category_category_id_seq from pg

BEGIN;

SELECT pg_catalog.setval('rental.category_category_id_seq', 1, true);

COMMIT;
