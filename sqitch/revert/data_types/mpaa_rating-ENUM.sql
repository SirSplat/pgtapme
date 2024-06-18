-- Revert db_design_intro:data_types/mpaa_rating-ENUM from pg

BEGIN;

DROP TYPE rental.mpaa_rating;

COMMIT;
