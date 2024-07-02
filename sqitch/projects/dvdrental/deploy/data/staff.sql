-- Deploy db_design_intro_data:data/staff to pg
-- requires: db_design_intro:@v0.1-pre-data

BEGIN;

INSERT INTO rental.staff (staff_id,first_name,last_name,address_id,email,store_id,active,username,"password",last_update,picture) VALUES
	 (1,'Mike','Hillyer',3,'Mike.Hillyer@sakilastaff.com',1,true,'Mike','8cb2237d0679ca88db6464eac60da96345513964','2006-05-16 16:13:11.79328',decode('89504E470D0A5A0A','hex')),
	 (2,'Jon','Stephens',4,'Jon.Stephens@sakilastaff.com',2,true,'Jon','8cb2237d0679ca88db6464eac60da96345513964','2006-05-16 16:13:11.79328',NULL);


COMMIT;
