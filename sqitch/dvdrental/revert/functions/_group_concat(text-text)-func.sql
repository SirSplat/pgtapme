-- Revert db_design_intro:functions/_group_concat-FUNC from pg

BEGIN;

DROP FUNCTION rental._group_concat( text, text );

COMMIT;
