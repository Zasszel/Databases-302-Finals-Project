-- 3.

DECLARE
    v_car_id       NUMBER := 1;
    v_mechanic_id  NUMBER := 1;
    v_op_id        NUMBER := 1;
    v_calendar_id  NUMBER := 1;
    v_part_id      NUMBER := 1;
    v_part_qty     NUMBER := 1;
    v_order_id     NUMBER := 1;

    v_new_job_id   NUMBER;
    v_repair_cost  NUMBER(10, 2);
    v_customer_id  NUMBER;
    v_already_exists NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_already_exists
    FROM jobs
    WHERE car_id = v_car_id AND calendar_id = v_calendar_id;

    IF v_already_exists > 0 THEN
        raise_application_error(-20001, 'CRITICAL: This transaction has already been processed!');
    END IF;

    INSERT INTO jobs (car_id, mechanic_id, op_id, field_job_id, calendar_id)
    VALUES (v_car_id, v_mechanic_id, v_op_id, NULL, v_calendar_id)
    RETURNING job_id INTO v_new_job_id;

    INSERT INTO parts_used (part_id, job_id)
    VALUES (v_part_id, v_new_job_id);

    UPDATE parts
    SET quantity = quantity - v_part_qty
    WHERE part_id = v_part_id;

    UPDATE parts_orders
    SET part_id = v_part_id
    WHERE part_id = v_part_id AND order_id = v_order_id;

    SELECT cost INTO v_repair_cost
    FROM operations
    WHERE op_id = v_op_id;

    SELECT customer_id INTO v_customer_id
    FROM cars
    WHERE car_id = v_car_id;

    UPDATE customers
    SET total_debt = total_debt + v_repair_cost
    WHERE customer_id = v_customer_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Mechanic shop transaction successfully completed and committed.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Transaction Aborted! Database state restored to original.');
        DBMS_OUTPUT.PUT_LINE('SQL Error Code: ' || SQLCODE || ' | Message: ' || SQLERRM);
END;
/

-- 4. a) Eljárás szinten

CREATE OR REPLACE PROCEDURE process_mechanic_job (
    p_car_id       IN NUMBER,
    p_mechanic_id  IN NUMBER,
    p_op_id        IN NUMBER,
    p_calendar_id  IN NUMBER,
    p_part_id      IN NUMBER,
    p_part_qty     IN NUMBER,
    p_order_id     IN NUMBER
) AS
    v_new_job_id   NUMBER;
    v_repair_cost  NUMBER(10, 2);
    v_customer_id  NUMBER;
    v_already_exists NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_already_exists
    FROM jobs
    WHERE car_id = p_car_id AND calendar_id = p_calendar_id;

    IF v_already_exists > 0 THEN
        raise_application_error(-20001, 'CRITICAL: This transaction has already been processed!');
    END IF;

    INSERT INTO jobs (car_id, mechanic_id, op_id, field_job_id, calendar_id)
    VALUES (p_car_id, p_mechanic_id, p_op_id, NULL, p_calendar_id)
    RETURNING job_id INTO v_new_job_id;

    INSERT INTO parts_used (part_id, job_id)
    VALUES (p_part_id, v_new_job_id);

    UPDATE parts
    SET quantity = quantity - p_part_qty
    WHERE part_id = p_part_id;

    UPDATE parts_orders
    SET part_id = p_part_id
    WHERE part_id = p_part_id AND order_id = p_order_id;

    SELECT cost INTO v_repair_cost
    FROM operations
    WHERE op_id = p_op_id;

    SELECT customer_id INTO v_customer_id
    FROM cars
    WHERE car_id = p_car_id;

    UPDATE customers
    SET total_debt = total_debt + v_repair_cost
    WHERE customer_id = v_customer_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transaction successfully committed via stored procedure.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Transaction Aborted via stored procedure! Changes rolled back.');
        RAISE;
END;
/

-- 4. b) Felület szinten

SET SERVEROUTPUT ON;

/

DECLARE
    v_car_id       NUMBER := 1;
    v_mechanic_id  NUMBER := 1;
    v_op_id        NUMBER := 1;
    v_calendar_id  NUMBER := 1;
    v_part_id      NUMBER := 1;
    v_part_qty     NUMBER := 1;
    v_order_id     NUMBER := 1;

    v_new_job_id   NUMBER;
    v_repair_cost  NUMBER(10, 2);
    v_customer_id  NUMBER;
    v_already_exists NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_already_exists
    FROM jobs
    WHERE car_id = v_car_id AND calendar_id = v_calendar_id;

    IF v_already_exists > 0 THEN
        raise_application_error(-20001, 'CRITICAL: This transaction has already been processed!');
    END IF;

    INSERT INTO jobs (car_id, mechanic_id, op_id, field_job_id, calendar_id)
    VALUES (v_car_id, v_mechanic_id, v_op_id, NULL, v_calendar_id)
    RETURNING job_id INTO v_new_job_id;

    INSERT INTO parts_used (part_id, job_id)
    VALUES (v_part_id, v_new_job_id);

    UPDATE parts
    SET quantity = quantity - v_part_qty
    WHERE part_id = v_part_id;

    UPDATE parts_orders
    SET part_id = v_part_id
    WHERE part_id = v_part_id AND order_id = v_order_id;

    SELECT cost INTO v_repair_cost
    FROM operations
    WHERE op_id = v_op_id;

    SELECT customer_id INTO v_customer_id
    FROM cars
    WHERE car_id = v_car_id;

    UPDATE customers
    SET total_debt = total_debt + v_repair_cost
    WHERE customer_id = v_customer_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Worksheet interface transaction successfully completed and committed.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Worksheet interface transaction aborted! Database rolled back.');
        DBMS_OUTPUT.PUT_LINE('SQL Error Code: ' || SQLCODE || ' | Message: ' || SQLERRM);
END;
/