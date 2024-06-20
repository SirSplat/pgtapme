BEGIN;
  SELECT plan(7);

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'changes', 'Table sqitch.changes should exist.');

  SELECT has_column('sqitch', 'changes', 'project', 'Column sqitch.changes.project should exist.');

  SELECT has_schema('sqitch', 'Schema sqitch should exist.');

  SELECT has_table('sqitch', 'projects', 'Table sqitch.projects should exist.');

  SELECT has_column('sqitch', 'projects', 'project', 'Column sqitch.projects.project should exist.');

  SELECT fk_ok('sqitch', 'changes', ARRAY['project']::TEXT[], 'sqitch', 'projects', ARRAY['project']::TEXT[], 'Foreign key sqitch.changes.changes_project_fkey should exist.');

  SELECT * FROM finish();
ROLLBACK;
