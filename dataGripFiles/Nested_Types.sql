--Explicit cursors
--So far SELECT INTO statements have been limited to a single row.
-- To process a result set with multiple rows, we use an Explicit Cursor.
--Lifecycle of a cursor:
--  1.DECLARE - define the sql query
--  2.OPEN - execute the query and identify the result set
--  3.FETCH - retrieve rows one by one into variables or a record
--  4.CLOSE - release the memory once processing is finished

-- DECLARE
--    -- 1. Declare the cursor and its query
--    CURSOR c_emp IS SELECT last_name, salary FROM employees WHERE department_id = 50; [1, 2]
--    v_emp c_emp%ROWTYPE; -- Use %ROWTYPE to match the cursor columns [2]
-- BEGIN
--    -- 2. Open the cursor
--    OPEN c_emp; [1]
--    LOOP
--       -- 3. Fetch each row into your variable
--       FETCH c_emp INTO v_emp; [1, 3]
--       EXIT WHEN c_emp%NOTFOUND; -- Exit when the active set is empty [3, 4]
--
--       DBMS_OUTPUT.PUT_LINE(v_emp.last_name || ': ' || v_emp.salary);
--    END LOOP;
--    -- 4. Close the cursor to free memory
--    CLOSE c_emp; [2, 3]
-- END;

declare
    cursor c_emp is select last_name, salary from EMPLOYEES where department_id = 50;
    v_emp c_emp%rowtype; --the record to match c_emp query output
    begin
    open c_emp;
    loop
        fetch c_emp into v_emp;
        --Put exit right after fetch - to not execute one extra time with empty values.
        exit when c_emp%notfound; --Exit when the active set is empty.
        DBMS_OUTPUT.PUT_LINE(v_emp.last_name || ' ' || v_emp.salary);
    end loop;
    close c_emp;
end;
/
--Cursor FOR Loops
--  To automatically handle open, fetch, exit when and close.
-- BEGIN
--    FOR r_emp IN (SELECT last_name, salary FROM employees WHERE department_id = 50) LOOP
--       DBMS_OUTPUT.PUT_LINE(r_emp.last_name || ': ' || r_emp.salary);
--    END LOOP;
-- END;
begin
    for r_emp in (
        select last_name, salary
        from EMPLOYEES
        where department_id = 50
        )
        loop
            DBMS_OUTPUT.PUT_LINE(r_emp.last_name || ': ' ||r_emp.salary);
        end loop;
end;
/
--User-Defined Record
--We can create our own custom data structures using the RECORD type.
--Group different variables under one name.
-- TYPE t_student IS RECORD (
--     name VARCHAR2(50),
--     gpa  NUMBER(3,2)
-- );
-- v_student t_student;
declare
    type t_product is record (
        prod_name varchar2(30),
        price number := 2400
                             );
    v_product t_product;
    begin
        v_product.prod_name := 'IPhone';
        DBMS_OUTPUT.PUT_LINE(v_product.prod_name || ' is ' || v_product.price || '$.');
end;
/
--Associative arrays - type of collections
--  -> key-value pairs
--  -> index can be an integer or a string.
-- DECLARE
--    TYPE t_phone_book IS TABLE OF VARCHAR2(50) INDEX BY VARCHAR2(20);
--    v_contacts t_phone_book;
-- BEGIN
--    v_contacts('Emergency') := '911';
--    DBMS_OUTPUT.PUT_LINE(v_contacts('Emergency'));
-- END;
declare
    type t_inventory is table of number index by varchar2(30);
    v_inventory t_inventory;
    begin
    v_inventory('Iphone') := 500;
    DBMS_OUTPUT.PUT_LINE(v_inventory('Iphone'));
end;
/
--Collection Methods
-- COUNT: Returns the number of elements currently in the collection
-- EXISTS(i): Returns TRUE if an element exists at the specified index
-- FIRST / LAST: Returns the first and last index in the collection
-- DELETE: Removes elements from the collection
declare
    type t_inventory is table of number index by varchar2(30);
    v_inventory t_inventory;
    begin
    v_inventory('Iphone') := 500;

    v_inventory('Samsung') := 300;
    DBMS_OUTPUT.PUT_LINE(v_inventory.COUNT);

    --v_inventory.DELETE('Iphone');
    if v_inventory.EXISTS('Iphone') then
        DBMS_OUTPUT.PUT_LINE(v_inventory('Iphone'));
    else
        DBMS_OUTPUT.PUT_LINE('Item does not exist in collection scope.');
    end if;


end;
/
--Looping through Collections:
--  Since associative array indexes are not necessarily sequential (specially when indexed by strings)
--      => we can't  always use a standard FOR i IN 1..count loop.
--Instead we use .FIRST and .NEXT methods to navigate through the keys.
-- DECLARE
--    v_key VARCHAR2(30);
-- BEGIN
--    v_key := v_inventory.FIRST; -- Get the first key
--    WHILE v_key IS NOT NULL LOOP
--       DBMS_OUTPUT.PUT_LINE('Product: ' || v_key || ', Quantity: ' || v_inventory(v_key));
--       v_key := v_inventory.NEXT(v_key); -- Move to the next key
--    END LOOP;
-- END;
declare
    type t_inventory is table of number index by varchar2(30);
    v_inventory t_inventory;
    v_key varchar2(30);
    begin
    v_inventory('Nokia') := 100;
    v_inventory('Iphone') := 500;
    v_inventory('Samsung') := 300;

    v_key := v_inventory.FIRST;
    while  v_key is not null loop
        DBMS_OUTPUT.PUT_LINE('Product: ' || v_key || ' has ' || v_inventory(v_key) || ' products in store.');
        v_key := v_inventory.NEXT(v_key);
        end loop;
end;
/
--Nested Tables: (adatbazisban tarolt kollekciok)
--  Are initially NULL and must be initialized using a constructor (a special function with the same name as the type) before use.
--  Are indexed by integers starting at 1.
--  Can become sparse if elements are deleted from the middle.
-- To declare a Nested Table:
--  1. Define the type.
--  2. Declare the variable: reference the type you just created.
declare
    type t_colors is table of varchar2(30);
    v_colors t_colors := t_colors('Red', 'Green', 'Blue'); --has to be initialized by a contructor with the same name -> otherwise COLLECTION_IS_NULL error.
    begin
    for i in 1..v_colors.COUNT loop
        DBMS_OUTPUT.PUT_LINE(v_colors(i));
        end loop;
end;
/
--Varrays (Variable-Size Arrays)
--  Collection that requires you to specify a maximum size during declaration.
--  Unlike nested tables, they:
--      Always maintain the order of elements.
--      Cannot have "gaps".
-- They are also initialized via a constructor.
declare
    type t_numbers is varray(5) of integer;
    v_numbers t_numbers := t_numbers(10, 20, 30);
    begin
        for i in 1..v_numbers.COUNT loop
            DBMS_OUTPUT.PUT_LINE(v_numbers(i));
            end loop;
end;
/
