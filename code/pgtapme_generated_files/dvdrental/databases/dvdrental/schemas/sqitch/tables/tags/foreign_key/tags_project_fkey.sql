BEGIN;
  SELECT plan(7);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'tags', 'Table sqitch.tags should exist.');

  SELECT has_column('sqitch', 'tags', 'project', 'Column sqitch.tags.project should exist.');

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'projects', 'Table sqitch.projects should exist.');

  SELECT has_column('sqitch', 'projects', 'project', 'Column sqitch.projects.project should exist.');

  SELECT fk_ok('sqitch', 'tags', ARRAY['project']::TEXT[], 'sqitch', 'projects', ARRAY['project']::TEXT[], 'Foreign key sqitch.tags.tags_project_fkey should exist.');

  SELECT * FROM finish();
ROLLBACK;
