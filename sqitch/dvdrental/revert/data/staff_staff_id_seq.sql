-- Revert db_design_intro:data/staff_staff_id_seq from pg

BEGIN;

SELECT pg_catalog.setval('rental.staff_staff_id_seq', 1, true);

COMMIT;
