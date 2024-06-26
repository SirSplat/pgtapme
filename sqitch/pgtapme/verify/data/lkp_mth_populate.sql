-- Verify pgtapme_dev:data/lkp_mth_populate on pg

BEGIN;

DO
$$
DECLARE
    v_count int;
BEGIN
    -- Check total row count
    SELECT COUNT(*) INTO v_count FROM pgtapme.lkp_mth;
    IF v_count != 12 THEN
        RAISE EXCEPTION 'Row count mismatch: expected 12, got %', v_count;
    END IF;

    -- Check each row individually
    PERFORM 1 FROM pgtapme.lkp_mth WHERE
        int_month_number = 1 AND
        long_name_uc = 'JANUARY' AND
        long_name_ic = 'January' AND
        long_name_lc = 'january' AND
        short_name_uc = 'JAN' AND
        short_name_ic = 'Jan' AND
        short_name_lc = 'jan' AND
        text_month_number = '01';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Data mismatch for January';
    END IF;

    PERFORM 1 FROM pgtapme.lkp_mth WHERE
        int_month_number = 2 AND
        long_name_uc = 'FEBRUARY' AND
        long_name_ic = 'February' AND
        long_name_lc = 'february' AND
        short_name_uc = 'FEB' AND
        short_name_ic = 'Feb' AND
        short_name_lc = 'feb' AND
        text_month_number = '02';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Data mismatch for February';
    END IF;

    PERFORM 1 FROM pgtapme.lkp_mth WHERE
        int_month_number = 3 AND
        long_name_uc = 'MARCH' AND
        long_name_ic = 'March' AND
        long_name_lc = 'march' AND
        short_name_uc = 'MAR' AND
        short_name_ic = 'Mar' AND
        short_name_lc = 'mar' AND
        text_month_number = '03';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Data mismatch for March';
    END IF;

    PERFORM 1 FROM pgtapme.lkp_mth WHERE
        int_month_number = 4 AND
        long_name_uc = 'APRIL' AND
        long_name_ic = 'April' AND
        long_name_lc = 'april' AND
        short_name_uc = 'APR' AND
        short_name_ic = 'Apr' AND
        short_name_lc = 'apr' AND
        text_month_number = '04';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Data mismatch for April';
    END IF;

    PERFORM 1 FROM pgtapme.lkp_mth WHERE
        int_month_number = 5 AND
        long_name_uc = 'MAY' AND
        long_name_ic = 'May' AND
        long_name_lc = 'may' AND
        short_name_uc = 'MAY' AND
        short_name_ic = 'May' AND
        short_name_lc = 'may' AND
        text_month_number = '05';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Data mismatch for May';
    END IF;

    PERFORM 1 FROM pgtapme.lkp_mth WHERE
        int_month_number = 6 AND
        long_name_uc = 'JUNE' AND
        long_name_ic = 'June' AND
        long_name_lc = 'june' AND
        short_name_uc = 'JUN' AND
        short_name_ic = 'Jun' AND
        short_name_lc = 'jun' AND
        text_month_number = '06';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Data mismatch for June';
    END IF;

    PERFORM 1 FROM pgtapme.lkp_mth WHERE
        int_month_number = 7 AND
        long_name_uc = 'JULY' AND
        long_name_ic = 'July' AND
        long_name_lc = 'july' AND
        short_name_uc = 'JUL' AND
        short_name_ic = 'Jul' AND
        short_name_lc = 'jul' AND
        text_month_number = '07';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Data mismatch for July';
    END IF;

    PERFORM 1 FROM pgtapme.lkp_mth WHERE
        int_month_number = 8 AND
        long_name_uc = 'AUGUST' AND
        long_name_ic = 'August' AND
        long_name_lc = 'august' AND
        short_name_uc = 'AUG' AND
        short_name_ic = 'Aug' AND
        short_name_lc = 'aug' AND
        text_month_number = '08';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Data mismatch for August';
    END IF;

    PERFORM 1 FROM pgtapme.lkp_mth WHERE
        int_month_number = 9 AND
        long_name_uc = 'SEPTEMBER' AND
        long_name_ic = 'September' AND
        long_name_lc = 'september' AND
        short_name_uc = 'SEP' AND
        short_name_ic = 'Sep' AND
        short_name_lc = 'sep' AND
        text_month_number = '09';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Data mismatch for September';
    END IF;

    PERFORM 1 FROM pgtapme.lkp_mth WHERE
        int_month_number = 10 AND
        long_name_uc = 'OCTOBER' AND
        long_name_ic = 'October' AND
        long_name_lc = 'october' AND
        short_name_uc = 'OCT' AND
        short_name_ic = 'Oct' AND
        short_name_lc = 'oct' AND
        text_month_number = '10';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Data mismatch for October';
    END IF;

    PERFORM 1 FROM pgtapme.lkp_mth WHERE
        int_month_number = 11 AND
        long_name_uc = 'NOVEMBER' AND
        long_name_ic = 'November' AND
        long_name_lc = 'november' AND
        short_name_uc = 'NOV' AND
        short_name_ic = 'Nov' AND
        short_name_lc = 'nov' AND
        text_month_number = '11';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Data mismatch for November';
    END IF;

    PERFORM 1 FROM pgtapme.lkp_mth WHERE
        int_month_number = 12 AND
        long_name_uc = 'DECEMBER' AND
        long_name_ic = 'December' AND
        long_name_lc = 'december' AND
        short_name_uc = 'DEC' AND
        short_name_ic = 'Dec' AND
        short_name_lc = 'dec' AND
        text_month_number = '12';
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Data mismatch for December';
    END IF;
END;
$$;

ROLLBACK;
