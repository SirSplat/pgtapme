BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'category', 'Table rental.category should exist.');

  SELECT has_column('rental', 'category', 'category_id', 'Column rental.category.category_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'category', 'category_pk', 'dbo', 'Index rental.category.category_pk should have the correct owner.');

  SELECT index_is_primary('rental', 'category', 'category_pk', 'Index rental.category.category_pk should be a primary key index.');

  SELECT index_is_unique('rental', 'category', 'category_pk', 'Index rental.category.category_pk should be a unique index.');

  SELECT index_is_type('rental', 'category', 'category_pk', 'btree', 'Index rental.category.category_pk should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
