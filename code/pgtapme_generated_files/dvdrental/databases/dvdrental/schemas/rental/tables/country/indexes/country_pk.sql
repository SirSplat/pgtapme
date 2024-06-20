BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'country', 'Table rental.country should exist.');

  SELECT has_column('rental', 'country', 'country_id', 'Column rental.country.country_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'country', 'country_pk', 'dbo', 'Index rental.country.country_pk should have the correct owner.');

  SELECT index_is_primary('rental', 'country', 'country_pk', 'Index rental.country.country_pk should be a primary key index.');

  SELECT index_is_unique('rental', 'country', 'country_pk', 'Index rental.country.country_pk should be a unique index.');

  SELECT index_is_type('rental', 'country', 'country_pk', 'btree', 'Index rental.country.country_pk should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
