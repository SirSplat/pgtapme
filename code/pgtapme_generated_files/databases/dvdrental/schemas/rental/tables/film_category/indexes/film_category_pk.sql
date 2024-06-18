BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film_category', 'Table rental.film_category should exist.');

  SELECT has_column('rental', 'film_category', 'film_id', 'Column rental.film_category.film_id should exist.');

  SELECT has_column('rental', 'film_category', 'category_id', 'Column rental.film_category.category_id should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT index_owner_is('rental', 'film_category', 'film_category_pk', 'dbo', 'Index rental.film_category.film_category_pk should have the correct owner.');

  SELECT index_is_primary('rental', 'film_category', 'film_category_pk', 'Index rental.film_category.film_category_pk should be a primary key index.');

  SELECT index_is_unique('rental', 'film_category', 'film_category_pk', 'Index rental.film_category.film_category_pk should be a unique index.');

  SELECT index_is_type('rental', 'film_category', 'film_category_pk', 'btree', 'Index rental.film_category.film_category_pk should be of the correct type.');

  SELECT * FROM finish();
ROLLBACK;
