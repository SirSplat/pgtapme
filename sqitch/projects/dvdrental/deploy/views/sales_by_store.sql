-- Deploy db_design_intro:views/sales_by_store to pg
-- requires: appschema
-- requires: tables/payment
-- requires: tables/rental
-- requires: tables/inventory
-- requires: tables/store
-- requires: tables/address
-- requires: tables/city
-- requires: tables/country
-- requires: tables/staff

BEGIN;

CREATE OR REPLACE VIEW rental.sales_by_store AS
 SELECT (((c.city)::text || ','::text) || (cy.country)::text) AS store,
    (((m.first_name)::text || ' '::text) || (m.last_name)::text) AS manager,
    sum(p.amount) AS total_sales
   FROM (((((((rental.payment p
     JOIN rental.rental r ON ((p.rental_id = r.rental_id)))
     JOIN rental.inventory i ON ((r.inventory_id = i.inventory_id)))
     JOIN rental.store s ON ((i.store_id = s.store_id)))
     JOIN rental.address a ON ((s.address_id = a.address_id)))
     JOIN rental.city c ON ((a.city_id = c.city_id)))
     JOIN rental.country cy ON ((c.country_id = cy.country_id)))
     JOIN rental.staff m ON ((s.manager_staff_id = m.staff_id)))
  GROUP BY cy.country, c.city, s.store_id, m.first_name, m.last_name
  ORDER BY cy.country, c.city;

COMMIT;
