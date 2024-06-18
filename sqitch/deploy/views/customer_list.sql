-- Deploy db_design_intro:views/customer_list to pg
-- requires: appschema
-- requires: tables/customer
-- requires: tables/address
-- requires: tables/city
-- requires: tables/country

BEGIN;

CREATE OR REPLACE VIEW rental.customer_list AS
 SELECT cu.customer_id AS id,
    (((cu.first_name)::text || ' '::text) || (cu.last_name)::text) AS name,
    a.address,
    a.postal_code AS "zip code",
    a.phone,
    city.city,
    country.country,
        CASE
            WHEN cu.activebool THEN 'active'::text
            ELSE ''::text
        END AS notes,
    cu.store_id AS sid
   FROM (((rental.customer cu
     JOIN rental.address a ON ((cu.address_id = a.address_id)))
     JOIN rental.city ON ((a.city_id = city.city_id)))
     JOIN rental.country ON ((city.country_id = country.country_id)));

COMMIT;
