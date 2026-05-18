create or replace package pkg_emp_management authid current_user
is
    function get_sal(p_id in number) return number;
end pkg_emp_management;
/
create or replace package body pkg_emp_management
is
    function get_sal(p_id in number)
    return number
    is
        v_sal number;
    begin
        select salary into v_sal
        from EMPLOYEES
            where employee_id = p_id;
        return v_sal;
    end get_sal;
end pkg_emp_management;

begin
    DBMS_OUTPUT.PUT_LINE(pkg_emp_management.get_sal(104));
end;
/