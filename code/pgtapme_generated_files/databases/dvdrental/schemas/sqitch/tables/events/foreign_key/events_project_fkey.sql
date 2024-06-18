BEGIN;
  SELECT plan(7);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'events', 'Table sqitch.events should exist.');

  SELECT has_column('sqitch', 'events', 'project', 'Column sqitch.events.project should exist.');

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'projects', 'Table sqitch.projects should exist.');

  SELECT has_column('sqitch', 'projects', 'project', 'Column sqitch.projects.project should exist.');

  SELECT fk_ok('sqitch', 'events', ARRAY['project']::TEXT[], 'sqitch', 'projects', ARRAY['project']::TEXT[], 'Foreign key sqitch.events.events_project_fkey should exist.');

  SELECT * FROM finish();
ROLLBACK;
