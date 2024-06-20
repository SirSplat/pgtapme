BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'rental', 'Table rental.rental should exist.');

  SELECT has_column('rental', 'rental', 'rental_id', 'Column rental.rental.rental_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'rental', 'rental_pk', 'dbo', 'Index rental.rental.rental_pk should have the correct owner.');

  SELECT index_is_primary('rental', 'rental', 'rental_pk', 'Index rental.rental.rental_pk should be a primary key index.');

  SELECT index_is_unique('rental', 'rental', 'rental_pk', 'Index rental.rental.rental_pk should be a unique index.');

  SELECT index_is_type('rental', 'rental', 'rental_pk', 'btree', 'Index rental.rental.rental_pk should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
