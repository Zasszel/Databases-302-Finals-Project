-- ==========================================
-- 1. FÜGGETLEN TÁBLÁK (Szülők)
-- ==========================================

-- FUEL_TYPE_CODES
insert all
    into fuel_type_codes (code, name) values ('D', 'diesel')
    into fuel_type_codes (code, name) values ('Gas', 'gasoline')
    into fuel_type_codes (code, name) values ('CNG', 'compressed natural gas')
    into fuel_type_codes (code, name) values ('LPG', 'liquefied petroleum gas')
    into fuel_type_codes (code, name) values ('EV', 'electricity')
    into fuel_type_codes (code, name) values ('H2', 'hydrogen')
    into fuel_type_codes (code, name) values ('B20', 'biodiesel')
    into fuel_type_codes (code, name) values ('E85', 'ethanol')
    into fuel_type_codes (code, name) values ('HEV', 'full hybrid electric')
    into fuel_type_codes (code, name) values ('MHEV', 'mild hybrid')
select * from dual;

-- CUSTOMERS
insert into customers (last_name, first_name, address, email, tel) values ('Smith', 'John', '123 Main St, City', 'john.smith@email.com', '+121234567890');
insert into customers (last_name, first_name, address, email, tel) values ('Doe', 'Jane', '456 Oak Ave, Town', 'jane.doe@email.com', '+441234567890');
insert into customers (last_name, first_name, address, email, tel) values ('Johnson', 'Alex', '789 Pine Rd, Village', 'alex.johnson@email.com', '+911234567890');
insert into customers (last_name, first_name, address, email, tel) values ('Brown', 'Chris', '101 Maple Blvd, City', 'chris.brown@email.com', '+491234567890');
insert into customers (last_name, first_name, address, email, tel) values ('Taylor', 'Emma', '202 Birch Ln, Suburb', 'emma.taylor@email.com', '+611234567890');
insert into customers (last_name, first_name, address, email, tel) values ('Williams', 'James', '303 Cedar Dr, District', 'james.williams@email.com', '+331234567890');
insert into customers (last_name, first_name, address, email, tel) values ('Jones', 'Sophia', '404 Elm St, City', 'sophia.jones@email.com', '+861234567890');
insert into customers (last_name, first_name, address, email, tel) values ('Miller', 'Michael', '505 Cherry Blvd, Town', 'michael.miller@email.com', '+551234567890');
insert into customers (last_name, first_name, address, email, tel) values ('Davis', 'Olivia', '606 Fir Rd, Village', 'olivia.davis@email.com', '+391234567890');
insert into customers (last_name, first_name, address, email, tel) values ('Garcia', 'Liam', '707 Ash St, Suburb', 'liam.garcia@email.com', '+811234567890');

-- MECHANICS
INSERT INTO mechanics (salary_id, last_name, first_name, address, email, tel, hire_date) VALUES (NULL, 'Smith', 'John', '123 Elm Street', 'john.smith@example.com', '1234567890', TO_DATE('2020-01-15', 'YYYY-MM-DD'));
INSERT INTO mechanics (salary_id, last_name, first_name, address, email, tel, hire_date) VALUES (NULL, 'Johnson', 'Emma', '456 Oak Avenue', 'emma.johnson@example.com', '2345678901', TO_DATE('2019-06-20', 'YYYY-MM-DD'));
INSERT INTO mechanics (salary_id, last_name, first_name, address, email, tel, hire_date) VALUES (NULL, 'Williams', 'Liam', '789 Pine Road', 'liam.williams@example.com', '3456789012', TO_DATE('2021-03-10', 'YYYY-MM-DD'));
INSERT INTO mechanics (salary_id, last_name, first_name, address, email, tel, hire_date) VALUES (NULL, 'Brown', 'Sophia', '321 Cedar Lane', 'sophia.brown@example.com', '4567890123', TO_DATE('2018-08-05', 'YYYY-MM-DD'));
INSERT INTO mechanics (salary_id, last_name, first_name, address, email, tel, hire_date) VALUES (NULL, 'Jones', 'Mason', '654 Birch Street', 'mason.jones@example.com', '5678901234', TO_DATE('2017-11-25', 'YYYY-MM-DD'));
INSERT INTO mechanics (salary_id, last_name, first_name, address, email, tel, hire_date) VALUES (NULL, 'Garcia', 'Olivia', '987 Maple Court', 'olivia.garcia@example.com', '6789012345', TO_DATE('2022-02-14', 'YYYY-MM-DD'));
INSERT INTO mechanics (salary_id, last_name, first_name, address, email, tel, hire_date) VALUES (NULL, 'Martinez', 'Noah', '159 Spruce Boulevard', 'noah.martinez@example.com', '7890123456', TO_DATE('2016-09-30', 'YYYY-MM-DD'));
INSERT INTO mechanics (salary_id, last_name, first_name, address, email, tel, hire_date) VALUES (NULL, 'Davis', 'Ava', '753 Willow Way', 'ava.davis@example.com', '8901234567', TO_DATE('2023-04-22', 'YYYY-MM-DD'));
INSERT INTO mechanics (salary_id, last_name, first_name, address, email, tel, hire_date) VALUES (NULL, 'Rodriguez', 'Ethan', '951 Aspen Circle', 'ethan.rodriguez@example.com', '9012345678', TO_DATE('2021-12-01', 'YYYY-MM-DD'));
INSERT INTO mechanics (salary_id, last_name, first_name, address, email, tel, hire_date) VALUES (NULL, 'Wilson', 'Isabella', '357 Redwood Drive', 'isabella.wilson@example.com', '0123456789', TO_DATE('2015-07-18', 'YYYY-MM-DD'));

-- OPERATIONS
INSERT INTO operations (op_description, time_required, cost) VALUES ('Routine vehicle maintenance including oil change and tire check', 120, 500);
INSERT INTO operations (op_description, time_required, cost) VALUES ('Engine diagnostics and tuning', 90, 300);
INSERT INTO operations (op_description, time_required, cost) VALUES ('Brake system inspection and repair', 150, 1000);
INSERT INTO operations (op_description, time_required, cost) VALUES ('Transmission fluid change and inspection', 60, 200);
INSERT INTO operations (op_description, time_required, cost) VALUES ('Battery replacement and electrical system check', 45, 150);
INSERT INTO operations (op_description, time_required, cost) VALUES ('Cooling system flush and radiator replacement', 180, 2000);
INSERT INTO operations (op_description, time_required, cost) VALUES ('Exhaust system repair and replacement', 120, 1400);
INSERT INTO operations (op_description, time_required, cost) VALUES ('Suspension system inspection and shock absorber replacement', 130, 3245);
INSERT INTO operations (op_description, time_required, cost) VALUES ('Fuel system cleaning and injector replacement', 110, 159);
INSERT INTO operations (op_description, time_required, cost) VALUES ('Clutch system repair and flywheel resurfacing', 140, 1289);

-- PARTS
INSERT INTO parts (name, description, quantity) VALUES ('Engine Oil', 'High-quality engine oil for vehicles, 5W-30', 10);
INSERT INTO parts (name, description, quantity) VALUES ('Oil Filter', 'Oil filter for engine oil change', 15);
INSERT INTO parts (name, description, quantity) VALUES ('Tires', 'All-season tire suitable for most vehicle models', 20);
INSERT INTO parts (name, description, quantity) VALUES ('Tire Pressure Sensor', 'Sensor for monitoring tire pressure', 10);
INSERT INTO parts (name, description, quantity) VALUES ('Spark Plugs', 'Set of spark plugs for engine tuning', 8);
INSERT INTO parts (name, description, quantity) VALUES ('Air Filter', 'Air filter for optimal engine performance', 12);
INSERT INTO parts (name, description, quantity) VALUES ('Brake Pads', 'High-performance brake pads for various vehicle models', 30);
INSERT INTO parts (name, description, quantity) VALUES ('Brake Discs', 'Brake discs for vehicle braking systems', 15);
INSERT INTO parts (name, description, quantity) VALUES ('Transmission Fluid', 'High-quality transmission fluid for vehicles', 5);
INSERT INTO parts (name, description, quantity) VALUES ('Transmission Filter', 'Filter for vehicle transmission systems', 10);
INSERT INTO parts (name, description, quantity) VALUES ('Car Battery', 'Standard car battery with 12V output', 8);
INSERT INTO parts (name, description, quantity) VALUES ('Alternator', 'Alternator for charging the vehicle battery', 4);
INSERT INTO parts (name, description, quantity) VALUES ('Radiator', 'Radiator for engine cooling system replacement', 6);
INSERT INTO parts (name, description, quantity) VALUES ('Coolant', 'Vehicle coolant for engine cooling', 12);
INSERT INTO parts (name, description, quantity) VALUES ('Exhaust Pipe', 'Replacement exhaust pipe for vehicles', 10);
INSERT INTO parts (name, description, quantity) VALUES ('Muffler', 'Muffler for noise reduction in exhaust systems', 8);
INSERT INTO parts (name, description, quantity) VALUES ('Shock Absorbers', 'Heavy-duty shock absorbers for suspension systems', 10);
INSERT INTO parts (name, description, quantity) VALUES ('Suspension Springs', 'Suspension springs for various vehicle models', 8);
INSERT INTO parts (name, description, quantity) VALUES ('Fuel Injectors', 'Fuel injectors for engine fuel system replacement', 10);
INSERT INTO parts (name, description, quantity) VALUES ('Fuel Filter', 'Fuel filter for cleaner fuel system operation', 15);
INSERT INTO parts (name, description, quantity) VALUES ('Clutch Disc', 'Clutch disc for manual transmission systems', 7);
INSERT INTO parts (name, description, quantity) VALUES ('Flywheel', 'Flywheel for manual transmission vehicle repair', 5);

-- ORDERS
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-01-20', 'YYYY-MM-DD'), 'ABC Distributors', 'Air Freight', TO_DATE('2024-01-25', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-02-28', 'YYYY-MM-DD'), 'XYZ Supplies', 'Ground Shipping', TO_DATE('2024-03-02', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-03-05', 'YYYY-MM-DD'), 'LMN Logistics', 'Sea Freight', TO_DATE('2024-03-05', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-03-10', 'YYYY-MM-DD'), 'Global Goods', 'Air Freight', TO_DATE('2024-01-09', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-03-12', 'YYYY-MM-DD'), 'Quick Ship', 'Ground Shipping', TO_DATE('2024-03-13', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-04-06', 'YYYY-MM-DD'), 'Rapid Supply', 'Air Freight', TO_DATE('2024-04-08', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-04-15', 'YYYY-MM-DD'), 'Speedy Deliveries', 'Ground Shipping', TO_DATE('2024-04-20', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-06-08', 'YYYY-MM-DD'), 'FastTrack', 'Sea Freight', TO_DATE('2024-06-16', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-06-09', 'YYYY-MM-DD'), 'Supply Co.', 'Air Freight', TO_DATE('2024-06-11', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-06-14', 'YYYY-MM-DD'), 'Mega Supply', 'Sea Freight', TO_DATE('2024-06-22', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-06-17', 'YYYY-MM-DD'), 'Direct Ship', 'Air Freight', TO_DATE('2024-06-18', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-06-18', 'YYYY-MM-DD'), 'Top Distributors', 'Ground Shipping', TO_DATE('2024-06-23', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-07-10', 'YYYY-MM-DD'), 'Trade Hub', 'Ground Shipping', TO_DATE('2024-07-17', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-07-12', 'YYYY-MM-DD'), 'Euro Distribution', 'Sea Freight', TO_DATE('2024-08-18', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-07-13', 'YYYY-MM-DD'), 'Bulk Movers', 'Air Freight', TO_DATE('2024-07-15', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-07-16', 'YYYY-MM-DD'), 'Best Distributors', 'Ground Shipping', TO_DATE('2024-07-20', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-08-17', 'YYYY-MM-DD'), 'Pro Suppliers', 'Sea Freight', TO_DATE('2024-08-25', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-08-18', 'YYYY-MM-DD'), 'Fleet Movers', 'Air Freight', TO_DATE('2024-08-21', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-08-19', 'YYYY-MM-DD'), 'Elite Distribution', 'Ground Shipping', TO_DATE('2024-08-26', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-09-22', 'YYYY-MM-DD'), 'World Supply', 'Ground Shipping', TO_DATE('2024-09-29', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-09-12', 'YYYY-MM-DD'), 'World Supply', 'Ground Shipping', TO_DATE('2024-09-14', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-09-27', 'YYYY-MM-DD'), 'Global Transports', 'Air Freight', TO_DATE('2024-09-29', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-10-20', 'YYYY-MM-DD'), 'Fast Movers', 'Sea Freight', TO_DATE('2024-10-28', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-10-21', 'YYYY-MM-DD'), 'Global Transports', 'Air Freight', TO_DATE('2024-10-24', 'YYYY-MM-DD'));
INSERT INTO orders (order_date, distributor, delivery_method, delivery_date) VALUES (TO_DATE('2024-12-22', 'YYYY-MM-DD'), 'World Supply', 'Ground Shipping', TO_DATE('2024-12-29', 'YYYY-MM-DD'));

-- FIELD_JOBS
INSERT INTO field_jobs (address, distance) VALUES ('123 Main St, Springfield', 150);
INSERT INTO field_jobs (address, distance) VALUES ('456 Elm St, Riverside', 200);
INSERT INTO field_jobs (address, distance) VALUES ('789 Oak St, Greenfield', 180);
INSERT INTO field_jobs (address, distance) VALUES ('101 Pine St, Lakeside', 250);
INSERT INTO field_jobs (address, distance) VALUES ('202 Maple St, Hilltop', 120);
INSERT INTO field_jobs (address, distance) VALUES ('303 Birch St, Downtown', 220);
INSERT INTO field_jobs (address, distance) VALUES ('404 Cedar St, Uptown', 160);
INSERT INTO field_jobs (address, distance) VALUES ('505 Spruce St, Eastside', 210);
INSERT INTO field_jobs (address, distance) VALUES ('606 Redwood St, Westside', 140);
INSERT INTO field_jobs (address, distance) VALUES ('707 Fir St, Old Town', 130);


-- ==========================================
-- 2. ELSŐ SZINTŰ GYERMEKTÁBLÁK
-- ==========================================

-- CARS (Függ: customers, fuel_type_codes)
INSERT INTO cars (customer_id, plate_number, brand_name, model_name, engine_code, vin, fabr_year, fuel_type, color, oil, km, tire_specs) VALUES (1, 'AB 12 XYZ', 'Toyota', 'Corolla', '1NZ-FE', 'JTDBU4EE9A1234567', 2015, 'Gas', 'Red', '5W-30', 80000, '205/55 R16 91 V');
INSERT INTO cars (customer_id, plate_number, brand_name, model_name, engine_code, vin, fabr_year, fuel_type, color, oil, km, tire_specs) VALUES (2, 'CD 34 ABC', 'Honda', 'Civic', 'R18Z1', '2HGFC2F59KH123456', 2018, 'D', 'Blue', '0W-20', 45000, '215/60 R16 94 H');
INSERT INTO cars (customer_id, plate_number, brand_name, model_name, engine_code, vin, fabr_year, fuel_type, color, oil, km, tire_specs) VALUES (3, 'EF 56 DEF', 'Ford', 'Focus', 'Duratec-HE', 'WF0AXXWPMAKA12345', 2012, 'Gas', 'White', '5W-20', 120000, '195/65 R15 91 T');
INSERT INTO cars (customer_id, plate_number, brand_name, model_name, engine_code, vin, fabr_year, fuel_type, color, oil, km, tire_specs) VALUES (4, 'GH 78 GHI', 'BMW', '320d', 'B47D20', 'WBA8D9C53KA123456', 2020, 'D', 'Black', '5W-40', 30000, '225/45 R17 91 W');
INSERT INTO cars (customer_id, plate_number, brand_name, model_name, engine_code, vin, fabr_year, fuel_type, color, oil, km, tire_specs) VALUES (5, 'IJ 90 JKL', 'Audi', 'A4', 'CYMC', 'WAUZZZ8K1CA123456', 2017, 'Gas', 'Silver', '5W-30', 65000, '245/40 R18 97 Y');
INSERT INTO cars (customer_id, plate_number, brand_name, model_name, engine_code, vin, fabr_year, fuel_type, color, oil, km, tire_specs) VALUES (6, 'KL 12 MNO', 'Volkswagen', 'Golf', 'CHHA', 'WVWZZZ3BZCE123456', 2016, 'D', 'Gray', '5W-30', 95000, '205/55 R16 91 V');
INSERT INTO cars (customer_id, plate_number, brand_name, model_name, engine_code, vin, fabr_year, fuel_type, color, oil, km, tire_specs) VALUES (7, 'MN 34 PQR', 'Mercedes', 'C-Class', 'OM651', 'WDD2050021F123456', 2019, 'D', 'Blue', '5W-40', 40000, '225/50 R17 94 W');
INSERT INTO cars (customer_id, plate_number, brand_name, model_name, engine_code, vin, fabr_year, fuel_type, color, oil, km, tire_specs) VALUES (8, 'OP 56 STU', 'Hyundai', 'Elantra', 'G4ND', 'KMHDH41EBEU123456', 2014, 'Gas', 'White', '5W-30', 110000, '205/60 R16 92 V');
INSERT INTO cars (customer_id, plate_number, brand_name, model_name, engine_code, vin, fabr_year, fuel_type, color, oil, km, tire_specs) VALUES (9, 'QR 78 VWX', 'Tesla', 'Model 3', 'None', '5YJ3E1EA3KF123456', 2021, 'EV', 'Red', 'None', 15000, '235/45 R18 98 Y');
INSERT INTO cars (customer_id, plate_number, brand_name, model_name, engine_code, vin, fabr_year, fuel_type, color, oil, km, tire_specs) VALUES (10, 'ST 90 YZA', 'Mazda', 'CX-5', 'PYR', 'JMZKF4W2A01234567', 2013, 'Gas', 'Green', '0W-20', 140000, '225/65 R17 91 H');
INSERT INTO cars (customer_id, plate_number, brand_name, model_name, engine_code, vin, fabr_year, fuel_type, color, oil, km, tire_specs) VALUES (1, 'ST 90 YZA', 'Mazda', 'CX-5', 'PYR', 'JMZKF4W2A01234567', 2013, 'Gas', 'Green', '0W-20', 140000, '225/65 R17 91 H');
INSERT INTO cars (customer_id, plate_number, brand_name, model_name, engine_code, vin, fabr_year, fuel_type, color, oil, km, tire_specs) VALUES (3, 'ST 90 YZA', 'Renault', 'Clio', 'PYR', 'JMZKF4W2A01574347', 2003, 'Gas', 'Gery', '5W-40', 250879, '225/65 R17 91 H');

-- PARTS_ORDERS (Függ: parts, orders)
INSERT INTO parts_orders (part_id, order_id) VALUES (1, 1);
INSERT INTO parts_orders (part_id, order_id) VALUES (2, 1);
INSERT INTO parts_orders (part_id, order_id) VALUES (3, 1);
INSERT INTO parts_orders (part_id, order_id) VALUES (4, 1);
INSERT INTO parts_orders (part_id, order_id) VALUES (5, 2);
INSERT INTO parts_orders (part_id, order_id) VALUES (6, 2);
INSERT INTO parts_orders (part_id, order_id) VALUES (7, 3);
INSERT INTO parts_orders (part_id, order_id) VALUES (8, 3);
INSERT INTO parts_orders (part_id, order_id) VALUES (9, 4);
INSERT INTO parts_orders (part_id, order_id) VALUES (10, 4);
INSERT INTO parts_orders (part_id, order_id) VALUES (11, 5);
INSERT INTO parts_orders (part_id, order_id) VALUES (12, 5);
INSERT INTO parts_orders (part_id, order_id) VALUES (13, 6);
INSERT INTO parts_orders (part_id, order_id) VALUES (14, 6);
INSERT INTO parts_orders (part_id, order_id) VALUES (15, 7);
INSERT INTO parts_orders (part_id, order_id) VALUES (16, 7);
INSERT INTO parts_orders (part_id, order_id) VALUES (17, 8);
INSERT INTO parts_orders (part_id, order_id) VALUES (18, 8);
INSERT INTO parts_orders (part_id, order_id) VALUES (19, 9);
INSERT INTO parts_orders (part_id, order_id) VALUES (20, 9);
INSERT INTO parts_orders (part_id, order_id) VALUES (21, 10);
INSERT INTO parts_orders (part_id, order_id) VALUES (22, 10);
INSERT INTO parts_orders (part_id, order_id) VALUES (1, 11);
INSERT INTO parts_orders (part_id, order_id) VALUES (2, 11);
INSERT INTO parts_orders (part_id, order_id) VALUES (3, 11);
INSERT INTO parts_orders (part_id, order_id) VALUES (4, 11);
INSERT INTO parts_orders (part_id, order_id) VALUES (5, 12);
INSERT INTO parts_orders (part_id, order_id) VALUES (6, 12);
INSERT INTO parts_orders (part_id, order_id) VALUES (7, 13);
INSERT INTO parts_orders (part_id, order_id) VALUES (8, 13);
INSERT INTO parts_orders (part_id, order_id) VALUES (9, 14);
INSERT INTO parts_orders (part_id, order_id) VALUES (10, 14);
INSERT INTO parts_orders (part_id, order_id) VALUES (11, 15);
INSERT INTO parts_orders (part_id, order_id) VALUES (12, 15);
INSERT INTO parts_orders (part_id, order_id) VALUES (13, 16);
INSERT INTO parts_orders (part_id, order_id) VALUES (14, 16);
INSERT INTO parts_orders (part_id, order_id) VALUES (15, 17);
INSERT INTO parts_orders (part_id, order_id) VALUES (16, 17);
INSERT INTO parts_orders (part_id, order_id) VALUES (17, 18);
INSERT INTO parts_orders (part_id, order_id) VALUES (18, 18);
INSERT INTO parts_orders (part_id, order_id) VALUES (19, 19);
INSERT INTO parts_orders (part_id, order_id) VALUES (20, 19);
INSERT INTO parts_orders (part_id, order_id) VALUES (21, 20);
INSERT INTO parts_orders (part_id, order_id) VALUES (22, 20);
INSERT INTO parts_orders (part_id, order_id) VALUES (1, 20);
INSERT INTO parts_orders (part_id, order_id) VALUES (3, 20);
INSERT INTO parts_orders (part_id, order_id) VALUES (8, 9);
INSERT INTO parts_orders (part_id, order_id) VALUES (8, 22); -- (Lásd a megjegyzést lent a 221-es id-król!)
INSERT INTO parts_orders (part_id, order_id) VALUES (7, 22);
INSERT INTO parts_orders (part_id, order_id) VALUES (5, 22);
INSERT INTO parts_orders (part_id, order_id) VALUES (1, 23);
INSERT INTO parts_orders (part_id, order_id) VALUES (4, 23);
INSERT INTO parts_orders (part_id, order_id) VALUES (6, 24);


-- ==========================================
-- 3. MÁSODIK SZINTŰ GYERMEKTÁBLÁK
-- ==========================================

-- JOBS (Függ: cars, mechanics, operations, field_jobs)
INSERT INTO jobs (calendar_id, car_id, mechanic_id, op_id, field_job_id) VALUES (NULL, 1, 1, 1, 1);
INSERT INTO jobs (calendar_id, car_id, mechanic_id, op_id, field_job_id) VALUES (NULL, 2, 2, 2, 2);
INSERT INTO jobs (calendar_id, car_id, mechanic_id, op_id, field_job_id) VALUES (NULL, 3, 3, 3, 3);
INSERT INTO jobs (calendar_id, car_id, mechanic_id, op_id, field_job_id) VALUES (NULL, 4, 4, 4, null);
INSERT INTO jobs (calendar_id, car_id, mechanic_id, op_id, field_job_id) VALUES (NULL, 5, 5, 5, 5);
INSERT INTO jobs (calendar_id, car_id, mechanic_id, op_id, field_job_id) VALUES (NULL, 6, 6, 6, null);
INSERT INTO jobs (calendar_id, car_id, mechanic_id, op_id, field_job_id) VALUES (NULL, 7, 7, 7, 7);
INSERT INTO jobs (calendar_id, car_id, mechanic_id, op_id, field_job_id) VALUES (NULL, 8, 8, 8, null);
INSERT INTO jobs (calendar_id, car_id, mechanic_id, op_id, field_job_id) VALUES (NULL, 9, 9, 9, null);
INSERT INTO jobs (calendar_id, car_id, mechanic_id, op_id, field_job_id) VALUES (NULL, 10, 10, 10, 10);
INSERT INTO jobs (calendar_id, car_id, mechanic_id, op_id, field_job_id) VALUES (NULL, 1, 4, 3, 4);
INSERT INTO jobs (calendar_id, car_id, mechanic_id, op_id, field_job_id) VALUES (NULL, 1, 4, 3, 4);

-- JOBS Test Triggers
INSERT INTO jobs (car_id, mechanic_id, op_id, field_job_id) VALUES (1, 2, 3, 4);
INSERT INTO jobs (car_id, mechanic_id, op_id, field_job_id) VALUES (3, 2, 3, 4);


-- ==========================================
-- 4. HARMADIK SZINTŰ GYERMEKTÁBLÁK
-- ==========================================

-- PARTS_USED (Függ: parts, jobs)
insert into parts_used (part_id, job_id) values (1, 1);
insert into parts_used (part_id, job_id) values (2, 1);
insert into parts_used (part_id, job_id) values (3, 1);
insert into parts_used (part_id, job_id) values (4, 1);
insert into parts_used (part_id, job_id) values (5, 2);
insert into parts_used (part_id, job_id) values (6, 2);
insert into parts_used (part_id, job_id) values (7, 3);
insert into parts_used (part_id, job_id) values (8, 3);
insert into parts_used (part_id, job_id) values (9, 4);
insert into parts_used (part_id, job_id) values (10, 4);
insert into parts_used (part_id, job_id) values (11, 5);
insert into parts_used (part_id, job_id) values (12, 5);
insert into parts_used (part_id, job_id) values (13, 6);
insert into parts_used (part_id, job_id) values (14, 6);
insert into parts_used (part_id, job_id) values (15, 7);
insert into parts_used (part_id, job_id) values (16, 7);
insert into parts_used (part_id, job_id) values (17, 8);
insert into parts_used (part_id, job_id) values (18, 8);
insert into parts_used (part_id, job_id) values (19, 9);
insert into parts_used (part_id, job_id) values (20, 9);
insert into parts_used (part_id, job_id) values (21, 10);
insert into parts_used (part_id, job_id) values (22, 10);

-- PARTS_USED Test Triggers
insert into parts_used (part_id, job_id) values (21, 3);
insert into parts_used (part_id, job_id) values (22, 3);
insert into parts_used (part_id, job_id) values (11, 3);
insert into parts_used (part_id, job_id) values (12, 3);