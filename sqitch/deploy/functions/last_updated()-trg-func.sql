-- Deploy db_design_intro:functions/last_updated()-trg-func to pg
-- requires: appschema

BEGIN;

CREATE OR REPLACE FUNCTION rental.last_updated_trg_func() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.last_update = CURRENT_TIMESTAMP;
    RETURN NEW;
END $$;

COMMIT;
