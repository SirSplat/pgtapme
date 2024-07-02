-- Deploy pgtapme_dev:data/d_date_exclusion_populate to pg
-- requires: appschema
-- requires: tables/d_date_with_exclusion_constraint
-- requires: functions/d_date_exclusion_populate-date-date

BEGIN;

INSERT INTO pgtapme.d_date_exclusion_alignment (
  "Date",
  "Full Date Description",
  "Day of Week",
  "Short Day of Week",
  "Day Number in Month",
  "Day Number in Year",
  "Last Day in Week Indicator",
  "Last Day in Month Indicator",
  "Week Ending Date",
  "Week Number in Year",
  "Week Number in Month",
  "Month Name",
  "Short Month Name",
  "Month Number in Year",
  "Year-Month",
  "Year Quarter",
  "Year-Quarter",
  "Year Half",
  "Year",
  "Weekday Indicator",
  "Year-Half",
  "SQL Date"
)
SELECT
  ( TO_CHAR( s.v::DATE, 'YYYY' ) || '-' || TO_CHAR( s.v::DATE, 'MM' ) || '-' || TO_CHAR( s.v::DATE, 'DD' ) )::TEXT AS "Date",
  BTRIM( TO_CHAR( s.v, 'Month' ) ) || ' ' || TO_CHAR( s.v, 'DD' )::smallint ||', ' || TO_CHAR( s.v, 'YYYY' )::smallint AS "Full Date Description",
  BTRIM( TO_CHAR( s.v, 'Day' ) ) AS "Day of Week",
  BTRIM( TO_CHAR( s.v, 'Dy' ) ) AS "Short Day of Week",
  TO_CHAR( s.v, 'DD' )::smallint AS "Day Number in Month",
  TO_CHAR( s.v, 'DDD' )::smallint AS "Day Number in Year",
  CASE TO_CHAR( s.v, 'D' )::smallint
    WHEN 6 THEN 'Last day in week'
    ELSE 'Not last day in week'
  END::TEXT AS "Last Day in Week Indicator",
  CASE
    WHEN TO_CHAR( s.v +INTERVAL '1 day', 'DD' )::smallint = 1
        THEN 'Last day in month'
    ELSE 'Not last day in month'
  END::TEXT AS "Last Day in Month Indicator",
  CASE TO_CHAR( s.v, 'D' )::smallint
    WHEN 1 THEN
      BTRIM( TO_CHAR( s.v +INTERVAL '5 days', 'Month' ) ) || ' ' || TO_CHAR( s.v +INTERVAL '5 days', 'DD' ) ||', ' || TO_CHAR( s.v +INTERVAL '5 days', 'YYYY' )
    WHEN 2 THEN
      BTRIM( TO_CHAR( s.v +INTERVAL '4 days', 'Month' ) ) || ' ' || TO_CHAR( s.v +INTERVAL '4 days', 'DD' ) ||', ' || TO_CHAR( s.v +INTERVAL '4 days', 'YYYY' )
    WHEN 3 THEN
      BTRIM( TO_CHAR( s.v +INTERVAL '3 days', 'Month' ) ) || ' ' || TO_CHAR( s.v +INTERVAL '3 days', 'DD' ) ||', ' || TO_CHAR( s.v +INTERVAL '3 days', 'YYYY' )
    WHEN 4 THEN
      BTRIM( TO_CHAR( s.v +INTERVAL '2 days', 'Month' ) ) || ' ' || TO_CHAR( s.v +INTERVAL '2 days', 'DD' ) ||', ' || TO_CHAR( s.v +INTERVAL '2 days', 'YYYY' )
    WHEN 5 THEN
      BTRIM( TO_CHAR( s.v +INTERVAL '1 day', 'Month' ) ) || ' ' || TO_CHAR( s.v +INTERVAL '1 day', 'DD' ) ||', ' || TO_CHAR( s.v +INTERVAL '1 day', 'YYYY' )
    WHEN 6 THEN
      BTRIM( TO_CHAR( s.v, 'Month' ) ) || ' ' || TO_CHAR( s.v, 'DD' ) ||', ' || TO_CHAR( s.v, 'YYYY' )
    WHEN 7 THEN
      BTRIM( TO_CHAR( s.v +INTERVAL '6 days', 'Month' ) ) || ' ' || TO_CHAR( s.v +INTERVAL '6 days', 'DD' ) ||', ' || TO_CHAR( s.v +INTERVAL '6 days', 'YYYY' )
  END::TEXT AS "Week Ending Date",
  TO_CHAR( s.v, 'WW' )::smallint AS "Week Number in Year",
  TO_CHAR( s.v, 'W' )::smallint AS "Week Number in Month",
  BTRIM( TO_CHAR( s.v, 'Month' ) ) AS "Month Name",
  BTRIM( TO_CHAR( s.v, 'Mon' ) ) AS "Short Month Name",
  TO_CHAR( s.v, 'MM' )::smallint AS "Month Number in Year",
  TO_CHAR( s.v, 'YYYY' )::smallint || '-' || BTRIM(TO_CHAR(s.v, 'Month')) AS "Year-Month",
  'Q' || TO_CHAR( s.v, 'Q' )::smallint AS "Year Quarter",
  TO_CHAR( s.v, 'YYYY' ) || '-Q' || TO_CHAR( s.v, 'Q' )::smallint AS "Year-Quarter",
  'H' ||
    CASE
      WHEN TO_CHAR( s.v, 'Q' )::smallint IN (1, 2) THEN 1
      ELSE 2
    END AS "Year Half",
  TO_CHAR( s.v, 'YYYY' ) AS "Year",
  CASE
    WHEN BTRIM( TO_CHAR( s.v, 'Dy' ) ) IN ( 'Mon', 'Tue', 'Wed', 'Thu', 'Fri' ) THEN 'Weekday'
    ELSE 'Weekend'
  END AS "Weekday Indicator",
  TO_CHAR( s.v, 'YYYY' ) || '-H' ||
    CASE
        WHEN TO_CHAR( s.v, 'Q' )::smallint IN ( 1, 2 ) THEN 1
        ELSE 2
    END AS "Year-Half",
  s.v::DATE AS "SQL Date"
FROM
  GENERATE_SERIES( '1 jan 0001'::DATE, '31 dec 30001'::DATE, '1 day'::INTERVAL ) AS s( v );

COMMIT;
