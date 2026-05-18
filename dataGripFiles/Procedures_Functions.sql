--Procedures
--CREATE OR REPLACE PROCEDURE [procedure_name] ([parameter_name] IN [type]) IS
--BEGIN
--  ...
--END;
create or replace procedure greet_user (p_name in varchar2) is
begin
    DBMS_OUTPUT.PUT_LINE('Hello ' || p_name || '.');
end;
/
--Calling procedure:
begin
    greet_user('Imets');
end;
/
--Functions
create or replace  function get_double(p_num in number)
return number
is
begin
    return p_num * 2;
end;
/
begin
    DBMS_OUTPUT.PUT_LINE('Func result: ' || get_double(2.2));
end;
/
