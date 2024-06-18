-- Deploy db_design_intro:functions/group_concat(text)-agg to pg
-- requires: appschema
-- requires: functions/_group_concat(text-text)-func

BEGIN;

CREATE AGGREGATE rental.group_concat(text) (
    SFUNC = rental._group_concat,
    STYPE = text
);

COMMIT;
