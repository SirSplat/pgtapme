BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'payment', 'Table rental.payment should exist.');

  SELECT has_column('rental', 'payment', 'payment_date', 'Column rental.payment.payment_date should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'timestamp', 'Data type pg_catalog.timestamp should exist.');

  SELECT col_not_null('rental', 'payment', 'payment_date', 'Column rental.payment.payment_date should be NOT NULL.');

  SELECT col_hasnt_default('rental', 'payment', 'payment_date', 'Column rental.payment.payment_date should not have DEFAULT.');

  SELECT col_type_is('rental', 'payment', 'payment_date', 'pg_catalog', 'timestamp without time zone', 'Column rental.payment.payment_date should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
