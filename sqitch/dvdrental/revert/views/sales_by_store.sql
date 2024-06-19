-- Revert db_design_intro:views/sales_by_store from pg

BEGIN;

DROP VIEW rental.sales_by_store;

COMMIT;
