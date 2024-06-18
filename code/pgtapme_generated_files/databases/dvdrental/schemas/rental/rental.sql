BEGIN;
  SELECT plan(15);

  SELECT has_schema('rental', 'Schema rental should exist.');

  SELECT has_role('dbo', 'Role dbo should exist.');

  SELECT schema_owner_is('rental', 'dbo', 'Schema rental should have the correct owner.');

  SELECT tables_are('rental', ARRAY['film_category', 'inventory', 'language', 'rental', 'film', 'actor', 'store', 'payment', 'address', 'category', 'city', 'staff', 'country', 'customer', 'film_actor']::TEXT[], 'Schema rental should have the correct tables.');

  SELECT foreign_tables_are('rental', ARRAY[]::TEXT[], 'Schema rental should have the correct foreign tables.');

  SELECT views_are('rental', ARRAY['customer_list', 'sales_by_film_category', 'film_list', 'sales_by_store', 'actor_info', 'nicer_but_slower_film_list', 'staff_list']::TEXT[], 'Schema rental should have the correct views.');

  SELECT materialized_views_are('rental', ARRAY[]::TEXT[], 'Schema rental should have the correct materialized views.');

  SELECT sequences_are('rental', ARRAY['language_language_id_seq', 'country_country_id_seq', 'inventory_inventory_id_seq', 'rental_rental_id_seq', 'store_store_id_seq', 'customer_customer_id_seq', 'film_film_id_seq', 'address_address_id_seq', 'city_city_id_seq', 'payment_payment_id_seq', 'staff_staff_id_seq', 'actor_actor_id_seq', 'category_category_id_seq']::TEXT[], 'Schema rental should have the correct sequences.');

  SELECT functions_are('rental', ARRAY['group_concat', '_group_concat', 'last_day', 'last_updated_trg_func', 'inventory_in_stock', 'film_in_stock', 'film_not_in_stock', 'get_customer_balance', 'inventory_held_by_customer', 'rewards_report']::TEXT[], 'Schema rental should have the correct functions.');

  SELECT opclasses_are('rental', ARRAY[]::TEXT[], 'Schema rental should have the correct opclasses.');

  SELECT types_are('rental', ARRAY['mpaa_rating', 'year']::TEXT[], 'Schema rental should have the correct types.');

  SELECT domains_are('rental', ARRAY['year']::TEXT[], 'Schema rental should have the correct domains.');

  SELECT enums_are('rental', ARRAY['mpaa_rating']::TEXT[], 'Schema rental should have the correct enums.');

  SELECT operators_are('rental', ARRAY[]::TEXT[], 'Schema rental should have the correct operators.');

  SELECT extensions_are('rental', ARRAY[]::TEXT[], 'Cluster should have the correct extensions');

  SELECT * FROM finish();
ROLLBACK;
