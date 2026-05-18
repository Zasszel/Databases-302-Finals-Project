--0
create or replace procedure dates_between(date1 in date, date2 in date)
is
begin
    for i in 0 .. (date2 - date1) loop
            DBMS_OUTPUT.PUT_LINE(date1 + i);
        end loop;
end;

begin
    dates_between(sysdate, sysdate + 20);
end;
/

--1
create or replace function working_days(
    date1 in date,
    date2 in date
)
return number
is
    v_count number;
begin
    select count(*)
        into v_count
    from (
        select sysdate + level - 1, to_char(sysdate + level - 1, 'DY')
        from dual
        where to_char(sysdate + level - 1, 'DY') not in ('SAT', 'SUN')
        connect by level <= date2 - date1);
    return v_count;
    exception
        when others then
            DBMS_OUTPUT.PUT_LINE('Error');
            record_error();
            return -1;
end;
/
begin
    DBMS_OUTPUT.PUT_LINE(working_days(sysdate, sysdate + 40));
end;
/

--3
create or replace function get_employees(p_depID in number)
return varchar2
is
    v_list varchar2(2000);
begin
    for i in (
        select last_name
        from EMPLOYEES
        where department_id = p_depID
        ) loop
        v_list := v_list || ',' || i.last_name;
        end loop;
    return v_list;
    exception
        when others then DBMS_OUTPUT.PUT_LINE('HIBA');
            RECORD_ERROR();
            return -1;
end;

select department_id, get_employees(department_id) as employees
from EMPLOYEES
group by department_id
order by department_id;
/

--2
create or replace function doDatesCross(
    p_Sdate1 in date,
    p_Edate1 in date,
    p_Sdate2 in date,
    p_Edate2 in date) return number
is
    v_doDatesCross number;
begin
    select case
        when p_Sdate1 <= p_Edate2 and p_Sdate2 < p_Edate2 then 1
        else 0
        end into v_doDatesCross;
    return v_doDatesCross;

    exception
        when others then
            RECORD_ERROR();
            return -1;
end;
declare
    v_temp number;
begin
    v_temp := doDatesCross(sysdate, sysdate + 7, sysdate + 2, sysdate + 3);
    if (v_temp = 1) then
        DBMS_OUTPUT.PUT_LINE('Yes the two date cross.');
        else if(v_temp = 0) then
            DBMS_OUTPUT.PUT_LINE('No they do not cross');
        else
            DBMS_OUTPUT.PUT_LINE('ERROR');
        end if;
    end if;
end;
/
create or replace procedure count_objects
is
    v_count number;
begin
    select count(*) into v_count
    from (select * from USER_OBJECTS);

    if (v_count > 20) then
        DBMS_OUTPUT.PUT_LINE('SOK ' || v_count);
    else
        DBMS_OUTPUT.PUT_LINE('KEVES');
    end if;
end;
begin
    count_objects();
end;
/
--5
--!BULK COLLECT into
-- SELECT .. INTO -> egy ertek betoltese egy valtozoba
-- BULK COLLECT INTO -> tobb ertek betoltese egy tombbe
create or replace procedure employee_names
is
    type t_employee_names is table of varchar2(30);
        v_employee_names t_employee_names;
    begin
        select last_name bulk collect into v_employee_names from EMPLOYEES;
        for i in 1 .. v_employee_names.COUNT loop
            DBMS_OUTPUT.PUT_LINE(v_employee_names(i));
            end loop;
    end;
begin
    employee_names();
end;
/
select * from EMPLOYEES;
create or replace function calc_salary(p_employee_id in number)
return number
is
    v_employee EMPLOYEES%rowtype;
    v_salary EMPLOYEES.salary%type;
begin
    select * into v_employee
    from EMPLOYEES
        where employee_id = p_employee_id;
    if (months_between(sysdate, v_employee.hire_date) < 12) then
        return v_employee.salary;
    end if;
    v_salary := (months_between(sysdate, v_employee.hire_date) / 12) * v_employee.salary;
    return v_salary;

    exception
        when NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('No employee with such id');
            return -1;
        when others then RECORD_ERROR();
            return -1;
end;

select last_name, hire_date, calc_salary(p_employee_id => employee_id)
       from EMPLOYEES;
/
-- declare
--     type t_employees is table of EMPLOYEES%rowtype;
--     v_employees t_employees;
-- begin
--     select * bulk collect into v_employees from EMPLOYEES;
--     for i in 1 .. v_employees.COUNT loop
--         if (v_employees(i).last_name like 'A%') then
--             v_employees(i).last_name := 'Mr./Mrs. ' || v_employees(i).last_name;
--         end if;
--         end loop;
--     create table employee_names();
-- end;