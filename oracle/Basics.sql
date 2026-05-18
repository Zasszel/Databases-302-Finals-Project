-print to dbms console
begin
    dbms_output.put_line('Hello word!');
end;
/
--string type
declare
    v_subject varchar2(20) := 'PL/SQL';
begin
    DBMS_OUTPUT.PUT_LINE('I am learning ' || v_subject);
end;
/
--number and date type
declare
    v_age number := 21;
    v_today date := sysdate;
begin
    DBMS_OUTPUT.PUT_LINE('My age is ' || v_age || '   ' || v_today);
end;
/
--IF-THEN-ELSE
declare
    v_age number := 21;
    v_today date := sysdate;
    begin
    if v_age >= 18
    then
        DBMS_OUTPUT.PUT_LINE('I am an adult.');
    else
        DBMS_OUTPUT.PUT_LINE('I am a minor.');
    end if;
end;
/
--Integrate SQL
--SELECT...INTO -> must return exactly one row
--              -> if finds nothing, it raises a NO_DATA_FOUND error
--              -> if it finds multiple rows, it raises a TOO_MANY_ROWS
select * from EMPLOYEES;
declare
    v_last_name EMPLOYEES.last_name%TYPE;
begin
    select last_name into v_last_name
    from EMPLOYEES
        where employee_id = 100;
    DBMS_OUTPUT.PUT_LINE('Employee 100 is ' || v_last_name);
end;
/

--Loops
--LOOP...EXIT/EXIT WHEN
--FOR LOOP - FOR I IN 1..10 LOOP
--WHILE LOOP - WHILE [condition] LOOP ... END LOOP;
begin
    for i in 1..5 loop
        DBMS_OUTPUT.PUT_LINE('Number: ' || i);
    end loop;
end;
/
declare
    v_num number := 0;
begin
    while v_num < 10 loop
        DBMS_OUTPUT.PUT(v_num);
        v_num := v_num + 1;
    end loop;
    DBMS_OUTPUT.PUT_LINE(''); --flush
end;
/
declare
    v_var number := 5;
begin
    loop
        DBMS_OUTPUT.PUT(v_var);
        v_var := v_var - 1;
        exit when v_var <= 0;
    end loop;
    DBMS_OUTPUT.PUT_LINE('');
end;
/
--%ROWTYPE - variable type - mathes the entire structure of a row in a table or cursor
--          -> it will automatically adapt if columns are added or removed from the table.
declare
    v_emp EMPLOYEES%rowtype;
    begin
    select * into v_emp
    from EMPLOYEES
        where employee_id = 100;
    DBMS_OUTPUT.PUT_LINE('Last name: ' || v_emp.last_name || ' and salary: ' || v_emp.salary);
end;
/
