-- Verify pgtapme_dev:data/d_date_exclusion_populate on pg

BEGIN;

DO
$$
DECLARE
    v_count int;
    v_min_date date;
    v_max_date date;
BEGIN
    -- Check total row count
    SELECT COUNT("SQL Date") INTO v_count FROM pgtapme.d_date_exclusion;
    ASSERT v_count = 365, 'Row count mismatch: expected 365, got: '|| v_count;

    SELECT MIN("SQL Date"), MAX("SQL Date") INTO v_min_date, v_max_date FROM pgtapme.d_date_exclusion;
    ASSERT v_min_date = '1 jan 0001', 'Min date mismatch: expected "1 Jan 0001", got: ' || v_min_date;
    ASSERT v_max_date = '31 dec 0001', 'Max date mismatch: expected "31 Dec 0001", got: ' || v_max_date;

END;
$$;

ROLLBACK;
