-- Deploy db_design_intro:data_types/year-DOMAIN to pg
-- requires: appschema

BEGIN;

CREATE DOMAIN rental.year AS integer
	CONSTRAINT year_check CHECK (((VALUE >= 1901) AND (VALUE <= 2155)));

COMMIT;
