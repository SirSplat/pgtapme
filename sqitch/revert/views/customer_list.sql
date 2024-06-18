-- Revert db_design_intro:views/customer_list from pg

BEGIN;

DROP VIEW rental.customer_list;

COMMIT;
