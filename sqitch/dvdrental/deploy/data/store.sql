-- Deploy db_design_intro_data:data/store to pg
-- requires: db_design_intro:@v0.1-pre-data

BEGIN;

INSERT INTO rental.store (store_id,manager_staff_id,address_id,last_update) VALUES
	 (1,1,1,'2006-02-15 09:57:12'),
	 (2,2,2,'2006-02-15 09:57:12');


COMMIT;
