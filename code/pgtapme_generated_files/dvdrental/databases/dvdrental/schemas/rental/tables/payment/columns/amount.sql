BEGIN;
  SELECT plan(8);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_table('rental', 'payment', 'Table rental.payment should exist.');

  SELECT has_column('rental', 'payment', 'amount', 'Column rental.payment.amount should exist.');

  SELECT has_schema('pg_catalog', 'Schema pg_catalog should exist.');

  SELECT has_type('pg_catalog', 'numeric', 'Data type pg_catalog.numeric should exist.');

  SELECT col_not_null('rental', 'payment', 'amount', 'Column rental.payment.amount should be NOT NULL.');

  SELECT col_hasnt_default('rental', 'payment', 'amount', 'Column rental.payment.amount should not have DEFAULT.');

  SELECT col_type_is('rental', 'payment', 'amount', 'pg_catalog', 'numeric(5,2)', 'Column rental.payment.amount should have the correct type.');

  SELECT * FROM finish();
ROLLBACK;
