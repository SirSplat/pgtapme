-- Revert db_design_intro:sequences/category_category_id_seq from pg

BEGIN;

DROP SEQUENCE rental.category_category_id_seq;

COMMIT;
