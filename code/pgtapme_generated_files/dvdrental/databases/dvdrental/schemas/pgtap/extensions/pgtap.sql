BEGIN;
  SELECT plan(2);

  SELECT has_schema('pgtap', 'Schema pgtap should exist.');

  SELECT has_extension('pgtap', 'pgtap', 'Extension pgtap.pgtap should exist.');

  SELECT * FROM finish();
ROLLBACK;
