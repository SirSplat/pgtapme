BEGIN;
  SELECT plan(9);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'film', 'Table rental.film should exist.');

  SELECT has_column('rental', 'film', 'replacement_cost', 'Column rental.film.replacement_cost should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'numeric', 'Data type pg_catalog.numeric should exist.');

  SELECT col_not_null('rental', 'film', 'replacement_cost', 'Column rental.film.replacement_cost should be NOT NULL.');

  SELECT col_has_default('rental', 'film', 'replacement_cost', 'Column rental.film.replacement_cost should have DEFAULT.');

  SELECT col_default_is('rental', 'film', 'replacement_cost', '19.99', 'Column rental.film.replacement_cost should have the correct default.');

  SELECT col_type_is('rental', 'film', 'replacement_cost', 'pg_catalog', 'numeric(5,2)', 'Column rental.film.replacement_cost should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
