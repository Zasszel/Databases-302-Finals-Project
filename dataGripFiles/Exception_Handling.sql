--Exception Handling: NO_DATA_FOUND, TOO_MANY_ROWS
declare
    v_last_name EMPLOYEES.last_name%type;
begin
    select last_name into v_last_name
    from EMPLOYEES
        where employee_id = 999;

    exception
        when NO_DATA_FOUND
            then DBMS_OUTPUT.PUT_LINE('Error: This employee ID does not exist.');
        when others
            then DBMS_OUTPUT.PUT_LINE('Unknown exception.');

end;
/
declare
    v_sal varchar2(20);
begin
    select salary into v_sal
    from EMPLOYEES
        where last_name = 'Koka';
    DBMS_OUTPUT.PUT_LINE(v_sal);
    exception
        when NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('No employee with such last name found.');
        when others then DBMS_OUTPUT.PUT_LINE('Unknown error.');
end;
/
