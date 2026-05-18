--Calculate bonus for a given mechanic based on jobs completed.
CREATE OR REPLACE FUNCTION fn_szerelo_bonusz (
    p_mechanic_id IN NUMBER
) RETURN NUMBER IS

    TYPE t_op_costs IS TABLE OF NUMBER;
    v_costs_tomb t_op_costs;

    v_salary_id        NUMBER;
    v_current_salary   NUMBER;
    v_field_job_count  NUMBER;
    v_total_work_value NUMBER := 0;
    v_calculated_bonus NUMBER := 0;

BEGIN

    SELECT salary_id
    INTO v_salary_id
    FROM mechanics
    WHERE mechanic_id = p_mechanic_id;

    SELECT NVL(current_salary, 0)
    INTO v_current_salary
    FROM salaries
    WHERE salary_id = v_salary_id;

    SELECT COUNT(*)
    INTO v_field_job_count
    FROM jobs
    WHERE mechanic_id = p_mechanic_id
      AND field_job_id IS NOT NULL;

    SELECT o.cost
    BULK COLLECT INTO v_costs_tomb
    FROM jobs j
    JOIN operations o ON j.op_id = o.op_id
    WHERE j.mechanic_id = p_mechanic_id;

    IF v_costs_tomb.COUNT > 0 THEN
        FOR i IN 1..v_costs_tomb.COUNT LOOP
            v_total_work_value := v_total_work_value + v_costs_tomb(i);
        END LOOP;
    END IF;

    IF v_field_job_count > 3 THEN
        v_calculated_bonus := v_current_salary * 0.25;

    ELSIF v_total_work_value > 150000 THEN
        v_calculated_bonus := v_current_salary * 0.15;

    ELSE
        v_calculated_bonus := v_current_salary * 0.05;
    END IF;

    RETURN v_calculated_bonus;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;

    WHEN OTHERS THEN
        RETURN 0;
END;
/
select * from fn_szerelo_bonusz(1);