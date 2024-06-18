BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'payment', 'Table rental.payment should exist.');

  SELECT has_column('rental', 'payment', 'rental_id', 'Column rental.payment.rental_id should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'int4', 'Data type pg_catalog.int4 should exist.');

  SELECT col_not_null('rental', 'payment', 'rental_id', 'Column rental.payment.rental_id should be NOT NULL.');

  SELECT col_hasnt_default('rental', 'payment', 'rental_id', 'Column rental.payment.rental_id should not have DEFAULT.');

  SELECT col_type_is('rental', 'payment', 'rental_id', 'pg_catalog', 'integer', 'Column rental.payment.rental_id should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
