create or replace trigger trg_mechanics_salaries
after insert on mechanics
for each row
declare
    new_starting_salary number  ;
begin

    new_starting_salary := 1200 + trunc(dbms_random.value(0, 1801));

    insert into salaries (salary_id, starting_salary, current_salary, bonuses, increase)
    values (:NEW.mechanic_id, new_starting_salary, new_starting_salary, 0, 0);

end;

drop trigger trg_mechanics_salaries;
---

create or replace trigger set_calendar
after insert on jobs
for each row
declare
    rand_date date;
begin

    rand_date := TO_DATE('2024-01-01', 'YYYY-MM-DD') + ROUND(DBMS_RANDOM.VALUE(0, 365));

    insert into calendars (calendar_id, in_date, out_date)
    values (:NEW.job_id, rand_date, rand_date + ROUND(DBMS_RANDOM.VALUE(0, 4)));
end;

drop trigger set_calendar;
---

create or replace trigger reduce_quantity
after insert on parts_used
for each row
begin
    update parts
    set quantity = quantity - 1
    where part_id = :NEW.part_id
            and quantity > 0;
end;

drop trigger reduce_quantity;

---
create or replace trigger TGR_UPDATE_CURRENT_SALARY
after insert on jobs
for each row
begin
    if :NEW.field_job_id is not null then

        update salaries
        set bonuses = bonuses + 5
        where salary_id = :NEW.mechanic_id;

        update salaries
        set current_salary = starting_salary + (starting_salary*bonuses/100)
        where salary_id = :NEW.mechanic_id;

        update salaries
        set increase = current_salary - starting_salary
        where salary_id = :NEW.mechanic_id;

    end if;
end;

drop trigger TGR_UPDATE_CURRENT_SALARY;
