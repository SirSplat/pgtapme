BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'language', 'Table rental.language should exist.');

  SELECT has_column('rental', 'language', 'language_id', 'Column rental.language.language_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'language', 'language_pk', 'dbo', 'Index rental.language.language_pk should have the correct owner.');

  SELECT index_is_primary('rental', 'language', 'language_pk', 'Index rental.language.language_pk should be a primary key index.');

  SELECT index_is_unique('rental', 'language', 'language_pk', 'Index rental.language.language_pk should be a unique index.');

  SELECT index_is_type('rental', 'language', 'language_pk', 'btree', 'Index rental.language.language_pk should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
