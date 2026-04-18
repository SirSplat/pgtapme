-- Deploy pgtapme_dev:data/d_date_declarative_populate_partitions to pg
-- requires: appschema
-- requires: tables/d_date_with_exclusion_constraint
-- requires: data/d_date_exclusion_populate
-- requires: tables/d_date_declarative

BEGIN;

INSERT INTO pgtapme.d_date_declarative(
    "Date", "Full Date Description", "Day of Week", "Short Day of Week", "Day Number in Month",
    "Day Number in Year", "Last Day in Week Indicator", "Last Day in Month Indicator",
    "Week Ending Date", "Week Number in Year", "Week Number in Month", "Month Name",
    "Short Month Name", "Month Number in Year", "Year-Month", "Year Quarter",
    "Year-Quarter", "Year Half", "Year", "Weekday Indicator", "Year-Half", "SQL Date"
)
SELECT
    "Date", "Full Date Description", "Day of Week", "Short Day of Week", "Day Number in Month",
    "Day Number in Year", "Last Day in Week Indicator", "Last Day in Month Indicator",
    "Week Ending Date", "Week Number in Year", "Week Number in Month", "Month Name",
    "Short Month Name", "Month Number in Year", "Year-Month", "Year Quarter",
    "Year-Quarter", "Year Half", "Year", "Weekday Indicator", "Year-Half", "SQL Date"
FROM
    pgtapme.d_date_exclusion;

COMMIT;
