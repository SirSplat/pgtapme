-- Deploy db_design_intro:views/staff_list to pg
-- requires: appschema
-- requires: tables/staff
-- requires: tables/address
-- requires: tables/city
-- requires: tables/country

BEGIN;

CREATE OR REPLACE VIEW rental.staff_list AS
 SELECT s.staff_id AS id,
    (((s.first_name)::text || ' '::text) || (s.last_name)::text) AS name,
    a.address,
    a.postal_code AS "zip code",
    a.phone,
    city.city,
    country.country,
    s.store_id AS sid
   FROM (((rental.staff s
     JOIN rental.address a ON ((s.address_id = a.address_id)))
     JOIN rental.city ON ((a.city_id = city.city_id)))
     JOIN rental.country ON ((city.country_id = country.country_id)));

COMMIT;
