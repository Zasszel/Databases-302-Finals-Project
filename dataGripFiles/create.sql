alter session set "_ORACLE_SCRIPT" = TRUE;

alter user SZAMT14 identified by Sapi1234;

create table salaries (
    salary_id number primary key,
    starting_salary number(10, 2),
    current_salary number(10, 2),
    bonuses number(10, 2),
    increase number(10, 2)
);

---

create table mechanics (
    mechanic_id number GENERATED ALWAYS AS IDENTITY primary key,
    salary_id number, -- ÚJ OSZLOP AZ IDEGEN KULCSNAK!
    last_name varchar2(100),
    first_name varchar2(100),
    address varchar2(100),
    email varchar2(100) unique,
    tel varchar2(10) unique check (REGEXP_LIKE(tel, '^\d{10}$')),
    hire_date date,
    constraint fk_salaries foreign key (salary_id) references salaries(salary_id)
);

---

create table customers (
    customer_id number generated always as identity primary key,
    last_name varchar2(100),
    first_name varchar2(100),
    address varchar2(500),
    email varchar2(100) unique,
    tel varchar2(20) unique check (REGEXP_LIKE(tel, '^\+\d{2}\d{10}$'))
);

---

create table fuel_type_codes (
    code varchar2(10) primary key,
    name varchar2(50)
);

---

create table cars (
    car_id number generated always as identity primary key,
    customer_id number,
    plate_number VARCHAR2(10) check (REGEXP_LIKE(plate_number, '^[A-Z]{2} \d{2} [A-Z]{3}$')),
    brand_name varchar2(100),
    model_name varchar2(100),
    engine_code varchar2(50),
    vin varchar2(100),
    fabr_year number(4),
    fuel_type varchar2(10),
    color varchar2(10),
    oil varchar2(100),
    km number,
    tire_specs varchar2(100) check (regexp_like(tire_specs, '^\d{3}/\d{2} R\d{2} \d{2} [A-Z]$')),
    constraint fk_fuel_type_codes foreign key (fuel_type) references fuel_type_codes(code),
    constraint fk_customers foreign key (customer_id) references customers(customer_id)
);

---

create table operations (
    op_id number generated always as identity primary key,
    op_description varchar2(2000),
    time_required number,
    cost number
);


---

create table orders (
    order_id number generated always as identity primary key,
    order_date date,
    distributor varchar2(100),
    delivery_method varchar2(100),
    delivery_date date
);

---

create table parts (
    part_id number generated always as identity primary key,
    name varchar2 (20),
    description varchar2(1000),
    quantity number
);

---

create table parts_orders (
    part_id number,
    order_id number,
    primary key (part_id, order_id),
    constraint fk_parts foreign key (part_id) references parts(part_id),
    constraint fk_orders foreign key (order_id) references orders(order_id)
);

---

create table calendars (
    calendar_id number primary key,
    in_date date,
    out_date date
);

---

create table field_jobs (
    field_job_id number generated always as identity primary key,
    address varchar2(100),
    distance number,
    cost number generated always as (distance * 6.25) virtual
);

---

create table jobs (
    job_id number generated always as identity primary key,
    car_id number,
    mechanic_id number,
    op_id number,
    field_job_id number default null,
    calendar_id number, -- ÚJ OSZLOP AZ IDEGEN KULCSNAK!
    constraint fk_cars_jobs foreign key (car_id) references cars(car_id),
    constraint fk_mechanics_jobs foreign key (mechanic_id) references mechanics(mechanic_id),
    constraint fk_operations_jobs foreign key (op_id) references operations(op_id),
    constraint fk_calendars_jobs foreign key (calendar_id) references calendars(calendar_id), -- JAVÍTOTT HIVATKOZÁS!
    constraint fk_field_job_id_jobs foreign key (field_job_id) references field_jobs(field_job_id)
);

---

create table parts_used (
    part_id number,
    job_id number,
    primary key (part_id, job_id),
    constraint fk_parts_parts_used foreign key (part_id) references parts(part_id),
    constraint fk_jobs_parts_used foreign key (job_id) references jobs(job_id)
);



