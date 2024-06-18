-- Deploy db_design_intro:data/staff_staff_id_seq to pg
-- requires: db_design_intro_data:@v0.1-data

BEGIN;

SELECT pg_catalog.setval('rental.staff_staff_id_seq', 2, true);

COMMIT;
