--Packages are database objects that group related:
--  types, variables, constants, cursors and subprograms.
-- In case of subprograms they consist of two mandatory parts:
--  -> Specification - The "public" interface that contains declarations visible to other applications.
--  -> Body - The "private" part that contains the actual implementation of the subprograms
--                  and internal declarations not visible outside the package.

-- Packages offer better security, as you can grant permission on the package itself rather than the underlying tables,
--          and improved performance because the entire package is loaded into memory when first called.

create or replace package pkg_math authid current_user
is
    function add_nums(num1 in number, num2 in number) return number;
end pkg_math;
/
create or replace package body pkg_math
is
    function add_nums(
        num1 in number,
        num2 in number
    )
    return number
    is
    begin
        return num1 + num2;
    end add_nums;
end pkg_math;

begin
    DBMS_OUTPUT.PUT_LINE(pkg_math.add_nums(1, 2)); --must prefix the function with the package name: pkg_math.add_nums
end;
/
