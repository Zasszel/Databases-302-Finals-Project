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
select * from calendars;
select * from parts_used;

------------------------------------------------------------------------------

describe fuel_type_codes;
describe customers;
describe cars;
describe mechanics;
describe salaries;
describe operations;
describe pars;
describe orders;
describe parts_orders;
describe field_jobs;
describe jobs;
describe parts_used;

------------------------------------------------------------------------------

--1. List�zzuk ki a szerel?ket aktu�lis fizet�seikkel egy�tt!
select m.first_name, m.last_name, s.current_salary
from mechanics m join salaries s
on m.mechanic_id = s.salary_id;

--2. List�zzuk ki a szerel?k neveit �s az �ltaluk v�gzett munk�k sz�m�t!
with a as (select mechanic_id, count(job_id) as job_count
from jobs
group by mechanic_id)

select first_name || ' ' || last_name as name, a.job_count as "Jobs done"
from mechanics m join a
on m.mechanic_id = a.mechanic_id;

--3. Minden �vben felvett szerel?k sz�ma �s neveik.
select extract(year from hire_date) as "Hire date", count(*) as "Count",
    listagg(first_name|| ' ' ||last_name, ', ') within group (order by last_name) as "Names"
from mechanics
group by extract(year from hire_date);

--4. Legmegfizetetteb szerelo.
select m.first_name ||' '|| m.last_name as name, s.current_salary as "Salary"
from salaries s join mechanics m
on s.salary_id = m.mechanic_id
where s.current_salary = (
    select max(current_salary)
    from salaries
);

--5.List�zzuk ki a kuncsaftok neveit �s az aut�ikat!
select cus.first_name ||' '||cus.last_name as name,
    listagg(c.brand_name ||' '|| c.model_name, ', ') within group (order by  c.brand_name ||' '|| c.model_name) as cars
from customers cus join cars c
on cus.customer_id = c.customer_id
group by name;

--6. Leg?s�gesebb kuncsaftok.
with a as (
    select c.customer_id,
        first_name ||' '|| last_name as name, count(j.job_id) as job_count
    from customers cus
    join cars c
    on c.customer_id = cus.customer_id
    join jobs j
    on j.car_id = c.car_id
    group by c.customer_id, first_name, last_name
)

select customer_id, name, job_count
from a
where job_count = (
    select max(job_count)
    from a
);

--7.Kifogyott alkatr�szek.
select name
from parts
where quantity = 0;


--8. Legt�bbet rendelt alkatr�szek!
with a as (
    select part_id, count(order_id) as count_parts
    from parts_orders
    group by part_id
)

select p.part_id ,name, count_parts as "Number of orders"
from parts p join a
on p.part_id = a.part_id
where count_parts = (
    select max(count_parts)
    from a
);

--9.Irassuk ki 2024 szeptember�ben letett rendl�sek adatait!
with a as (
    select po.order_id, po.part_id
    from parts_orders po join orders o
    on po.order_id = o.order_id
    where to_char(o.order_date, 'DD-MON-YY') like '%-SEP-24'
),

    b as (
    select a.order_id, listagg(p.name, ', ') within group (order by p.name) as names
    from parts p join a
    on p.part_id = a.part_id
    group by a.order_id
)

select o.order_id, o.order_date, o.distributor, o.delivery_method, b.names as "Parts Ordered"
from orders o join b
on o.order_id = b.order_id;

--10. Leghaszn�ltabb �zemanyagt�pus!

with a as (
    select fuel_type, count(fuel_type) as count
    from cars
    group by fuel_type
)

select name, a.count as "Number of cars using it"
from fuel_type_codes ftc join a
on ftc.code = a.fuel_type
where a.count = (
    select max(count)
    from a
);

--11. List�zzuk az �sszes munk�t �s t�rs�tsuk ?ket a hozz�juk tartoz� m?velettel
--de csak akkor ha a m?velet id?ig�nye kevesebb mint 90 perc!

select j.*, op_description, time_required
from jobs j
outer apply (
    select op_id, op_description, time_required
    from operations op
    where time_required < 90
    and j.op_id = op.op_id
)
order by job_id;

--12.Havi besz�mol� 2024 marcius�r�l


select  m.first_name ||' '|| m.last_name as mechanic_name,
    op.op_description,
    c.brand_name ||' '|| c.model_name ||' '|| c.fabr_year as car,
    cus.first_name ||' '|| cus.last_name as customer_name,
    sum(op.cost) as total_cost
from jobs j
join operations op
    on j.op_id = op.op_id
join calendars cal
    on j.job_id = cal.calendar_id
join cars c
    on j.car_id = c.car_id
join mechanics m
    on j.mechanic_id = m.mechanic_id
join customers cus
    on c.customer_id = cus.customer_id
where extract(year from cal.out_date) = 2024
    and extract(month from cal.out_date) = 3
group by rollup (mechanic_name, op.op_description, car, customer_name)
order by mechanic_name, op_description, car, customer_name;

--13.A h�nap dolgoz�ja (aki a legnagyobb p�nzmennyis�get hozta be az aktu�lis h�napban).
with a as (
    select m.first_name ||' '|| m.last_name as mechanic_name, (sum(op.cost) + sum(fj.cost)) cost_sum
    from jobs j
    join operations op
        on j.op_id = op.op_id
    join calendars cal
        on j.job_id = cal.calendar_id
    join cars c
        on j.car_id = c.car_id
    join mechanics m
        on j.mechanic_id = m.mechanic_id
    join customers cus
        on c.customer_id = cus.customer_id
    join field_jobs fj
        on j.field_job_id = fj.field_job_id
    group by mechanic_name
)

select mechanic_name as Name, cost_sum as income
from a
where cost_sum = (
    select max(cost_sum)
    from a
);

--14.Bonusok �s fizet�s n�veked�sek szerel?kk�nt,
--a fizet�s n�veked�s szerint novekv? sorrenbe.
select * from salaries;
select m.mechanic_id as id, m.first_name ||' '|| m.last_name as name, s.bonuses, s.increase
from mechanics m
join salaries s
on m.mechanic_id = s.salary_id
order by increase;

--15 M?veletek �s az �ltaluk haszn�lta alkatr�szek!
select j.job_id ,o.op_description, p.name
from jobs j
join operations o
    on j.op_id = o.op_id
join parts_used pu
    on j.job_id = pu.job_id
join parts p
    on pu.part_id = p.part_id;

--16 Irassuk ki a CV jelz�s? au�kat �s tulajdonosaik nev�t.
select c.brand_name ||' '|| c.model_name as car,
    c.plate_number,
    cus.first_name ||' '|| cus.last_name as customer
from cars c join customers cus
    on c.customer_id = cus.customer_id
where c.plate_number like 'CV%';

--17.Irjuk ki megy�nk�nt h�ny aut� van regisztr�lva de csak abban az esetben
--ha egyn�l t�bb auto van adott megy�re.
select REGEXP_SUBSTR(plate_number, '^[A-Z]{2}', 1, 1) as county,
    count(plate_number) as "num of cars registered there"
from cars
group by REGEXP_SUBSTR(plate_number, '^[A-Z]{2}', 1, 1)
having count(plate_number) > 1;

--18. Irjuk ki a top h�rom legk�lts�gesebb m?velet le�r�s�t.
select op_description, cost
from operations
order by cost desc
fetch first 3 rows only;

--19. List�zzuk ki azon terepmunk�kat �s a relev�ns szerel?t
--ahol a a t�vols�g meghaladja a 100 kilom�tert!
select  fj.*, m.*
from field_jobs fj
join jobs j
    on fj.field_job_id = j.field_job_id
join mechanics m
    on m.mechanic_id = j.mechanic_id
where distance > 100
order by distance;

--20. Irassuk ki azon szerel?k kersztneveit, akik soha nem v�geztek terepmunk�t.
select m.mechanic_id, m.first_name
from jobs j join mechanics m
    on j.mechanic_id = m.mechanic_id
minus
select m.mechanic_id, m.first_name
from jobs j join mechanics m
    on j.mechanic_id = m.mechanic_id
where field_job_id is not null;


------------------------------------------------------------------------------


explain plan for
select * from mechanics;

explain plan for
select * from mechanics
order by first_name, last_name;

explain plan for
select first_name ||' '|| last_name
from mechanics
where first_name = 'Emma';
---
explain plan for
select *
from mechanics m join salaries s
on m.mechanic_id = s.salary_id
where s.current_salary > 2500;


---
explain plan for
select cus.first_name ||' '||cus.last_name as name,
    listagg(c.brand_name ||' '|| c.model_name, ', ') within group (order by  c.brand_name ||' '|| c.model_name) as cars
from customers cus join cars c
on cus.customer_id = c.customer_id
group by name;
---
explain plan for
with a as (
    select fuel_type, count(fuel_type) as count
    from cars
    group by fuel_type
)

select name, a.count as "Number of cars using it"
from fuel_type_codes ftc join a
on ftc.code = a.fuel_type
where a.count = (
    select max(count)
    from a
);
---
explain plan for
with a as (
    select po.order_id, po.part_id
    from parts_orders po join orders o
    on po.order_id = o.order_id
    where to_char(o.order_date, 'DD-MON-YY') like '%-SEP-24'
),

    b as (
    select a.order_id, listagg(p.name, ', ') within group (order by p.name) as names
    from parts p join a
    on p.part_id = a.part_id
    group by a.order_id
)

select o.order_id, o.order_date, o.distributor, o.delivery_method, b.names as "Parts Ordered"
from orders o join b
on o.order_id = b.order_id;
---
explain plan for
with a as (
    select c.customer_id,
        first_name ||' '|| last_name as name, count(j.job_id) as job_count
    from customers cus
    join cars c
    on c.customer_id = cus.customer_id
    join jobs j
    on j.car_id = c.car_id
    group by c.customer_id, first_name, last_name
)

select customer_id, name, job_count
from a
where job_count = (
    select max(job_count)
    from a
);
---
explain plan for
select name
from parts
where quantity = 0;

----
SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

---------------------------------------------------------
--1. A szerel?k list�z�sa JSON-al.
select json_object(
    'id: ' value mechanic_id,
    'name:' value first_name ||' '|| last_name,
    'address:' value address,
    'email:' value email,
    'tel' VALUE tel,
    'hire_date' VALUE TO_CHAR(hire_date, 'YYYY-MM-DD')
) as mechanic_json
from mechanics;

--2. List�zzuk ki a kuncsaftok neveit �s az aut�ikat!
select json_object(
    'name:' value cus.first_name ||' '||cus.last_name,
    'cars:' value listagg(c.brand_name ||' '|| c.model_name, ', ') within group (order by  c.brand_name ||' '|| c.model_name)
) as cars_and_owners_json
from customers cus join cars c
on cus.customer_id = c.customer_id
group by cus.first_name ||' '||cus.last_name;

