-- Revert db_design_intro:functions/group_concat(text)-agg from pg

BEGIN;

DROP AGGREGATE rental.group_concat(text);

COMMIT;
