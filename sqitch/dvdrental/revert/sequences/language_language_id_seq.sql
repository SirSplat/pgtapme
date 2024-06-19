-- Revert db_design_intro:sequences/language_language_id_seq from pg

BEGIN;

DROP SEQUENCE rental.language_language_id_seq;

COMMIT;
