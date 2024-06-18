-- Revert db_design_intro:indexes/rental_rental_date_inventory_id_customer_id_uidx from pg

BEGIN;

DROP INDEX rental.rental_rental_date_inventory_id_customer_id_uidx;

COMMIT;
