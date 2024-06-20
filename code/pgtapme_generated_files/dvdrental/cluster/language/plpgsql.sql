BEGIN;
  SELECT plan(4);

  SELECT has_language('plpgsql', 'Language plpgsql should exist.');

  SELECT has_role('postgres', 'Role postgres should exist.');

  SELECT language_owner_is('plpgsql', 'postgres', 'Language plpgsql should have the correct owner.');

  SELECT language_is_trusted('plpgsql', 'Language plpgsql should exist.');

  SELECT * FROM finish();
ROLLBACK;
