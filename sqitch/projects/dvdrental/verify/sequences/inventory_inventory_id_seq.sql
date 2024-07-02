-- Verify db_design_intro:sequences/inventory_inventory_id_seq on pg

BEGIN;

SELECT pg_catalog.has_sequence_privilege( current_user, 'rental.inventory_inventory_id_seq', 'usage' );

ROLLBACK;
