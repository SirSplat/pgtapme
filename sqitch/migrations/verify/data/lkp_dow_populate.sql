-- Verify pgtapme_dev:data/lkp_dow_populate on pg

BEGIN;

DO
$$
DECLARE
    v_count int;
BEGIN
    -- Check total row count
    SELECT COUNT(*) INTO v_count FROM pgtapme.lkp_dow;
    IF v_count != 7 THEN
        RAISE EXCEPTION 'Row count mismatch: expected 7, got %', v_count;
    END IF;

    -- Check each row individually
    PERFORM 1 FROM pgtapme.lkp_dow WHERE
        int_iso_day_of_week_number = 1 AND
        int_day_of_week_number = 2 AND
        NOT is_weekend AND
        long_name_uc = 'MONDAY' AND
        long_name_ic = 'Monday' AND
        long_name_lc = 'monday' AND
        short_name_uc = 'MON' AND
        short_name_ic = 'Mon' AND
        short_name_lc = 'mon' AND
        text_iso_day_of_week_number = '01' AND
        text_int_day_of_week_number = '02';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Data mismatch for Monday';
    END IF;

    PERFORM 1 FROM pgtapme.lkp_dow WHERE
        int_iso_day_of_week_number = 2 AND
        int_day_of_week_number = 3 AND
        NOT is_weekend AND
        long_name_uc = 'TUESDAY' AND
        long_name_ic = 'Tuesday' AND
        long_name_lc = 'tuesday' AND
        short_name_uc = 'TUE' AND
        short_name_ic = 'Tue' AND
        short_name_lc = 'tue' AND
        text_iso_day_of_week_number = '02' AND
        text_int_day_of_week_number = '03';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Data mismatch for Tuesday';
    END IF;

    PERFORM 1 FROM pgtapme.lkp_dow WHERE
        int_iso_day_of_week_number = 3 AND
        int_day_of_week_number = 4 AND
        NOT is_weekend AND
        long_name_uc = 'WEDNESDAY' AND
        long_name_ic = 'Wednesday' AND
        long_name_lc = 'wednesday' AND
        short_name_uc = 'WED' AND
        short_name_ic = 'Wed' AND
        short_name_lc = 'wed' AND
        text_iso_day_of_week_number = '03' AND
        text_int_day_of_week_number = '04';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Data mismatch for Wednesday';
    END IF;

    PERFORM 1 FROM pgtapme.lkp_dow WHERE
        int_iso_day_of_week_number = 4 AND
        int_day_of_week_number = 5 AND
        NOT is_weekend AND
        long_name_uc = 'THURSDAY' AND
        long_name_ic = 'Thursday' AND
        long_name_lc = 'thursday' AND
        short_name_uc = 'THU' AND
        short_name_ic = 'Thu' AND
        short_name_lc = 'thu' AND
        text_iso_day_of_week_number = '04' AND
        text_int_day_of_week_number = '05';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Data mismatch for Thursday';
    END IF;

    PERFORM 1 FROM pgtapme.lkp_dow WHERE
        int_iso_day_of_week_number = 5 AND
        int_day_of_week_number = 6 AND
        NOT is_weekend AND
        long_name_uc = 'FRIDAY' AND
        long_name_ic = 'Friday' AND
        long_name_lc = 'friday' AND
        short_name_uc = 'FRI' AND
        short_name_ic = 'Fri' AND
        short_name_lc = 'fri' AND
        text_iso_day_of_week_number = '05' AND
        text_int_day_of_week_number = '06';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Data mismatch for Friday';
    END IF;

    PERFORM 1 FROM pgtapme.lkp_dow WHERE
        int_iso_day_of_week_number = 6 AND
        int_day_of_week_number = 7 AND
        is_weekend AND
        long_name_uc = 'SATURDAY' AND
        long_name_ic = 'Saturday' AND
        long_name_lc = 'saturday' AND
        short_name_uc = 'SAT' AND
        short_name_ic = 'Sat' AND
        short_name_lc = 'sat' AND
        text_iso_day_of_week_number = '06' AND
        text_int_day_of_week_number = '07';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Data mismatch for Saturday';
    END IF;

    PERFORM 1 FROM pgtapme.lkp_dow WHERE
        int_iso_day_of_week_number = 7 AND
        int_day_of_week_number = 1 AND
        is_weekend AND
        long_name_uc = 'SUNDAY' AND
        long_name_ic = 'Sunday' AND
        long_name_lc = 'sunday' AND
        short_name_uc = 'SUN' AND
        short_name_ic = 'Sun' AND
        short_name_lc = 'sun' AND
        text_iso_day_of_week_number = '07' AND
        text_int_day_of_week_number = '01';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Data mismatch for Sunday';
    END IF;

END;
$$;

ROLLBACK;
