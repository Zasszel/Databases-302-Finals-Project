-- ==========================================
-- LEKÉRDEZÉSEK / TESZTEK
-- ==========================================
select * from fuel_type_codes;
select * from customers;
select * from cars;
select * from mechanics;
select * from salaries;
select * from operations;
select * from parts;
select * from orders;
select * from parts_orders;
select * from field_jobs;
select * from jobs;

SELECT constraint_name, search_condition
FROM user_constraints
WHERE table_name = 'CARS' AND constraint_type = 'C';

SELECT '205/55 R123 16 H' AS tire_specs,
       CASE WHEN REGEXP_LIKE('205/55 R123 16 H', '^\d{3}/\d{2} [A-Z]\d{3} \d{2} [A-Z]$') THEN 'Valid'
            ELSE 'Invalid'
       END AS validation_status
FROM dual;

SELECT 'MN 34 PQR' AS tire_specs,
       CASE WHEN REGEXP_LIKE('MN 34 PQR', '^[A-Z]{2} \d{2} [A-Z]{3}$') THEN 'Valid'
            ELSE 'Invalid'
       END AS validation_status
FROM dual;