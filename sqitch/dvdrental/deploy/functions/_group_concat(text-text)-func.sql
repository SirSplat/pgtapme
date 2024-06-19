-- Deploy db_design_intro:functions/_group_concat-FUNC to pg
-- requires: appschema

BEGIN;

CREATE OR REPLACE FUNCTION rental._group_concat(text, text)
    RETURNS text
    LANGUAGE sql IMMUTABLE
AS $_$
SELECT CASE
  WHEN $2 IS NULL THEN $1
  WHEN $1 IS NULL THEN $2
  ELSE $1 || ', ' || $2
END
$_$;

COMMIT;
