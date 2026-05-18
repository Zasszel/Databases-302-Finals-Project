-- 1. Legeneráljuk és beszúrjuk a fizetéseket a meglévő szerelők alapján
INSERT INTO salaries (salary_id, starting_salary, current_salary, bonuses, increase)
SELECT
    mechanic_id,
    rnd_salary,
    rnd_salary,
    0,
    0
FROM (
    -- Itt generáljuk le a random fizetést minden szerelőnek
    SELECT mechanic_id, 1200 + trunc(dbms_random.value(0, 1801)) AS rnd_salary
    FROM mechanics
    WHERE salary_id IS NULL
);

-- 2. Frissítjük a szerelőket, hogy a saját új fizetésükre mutassanak
UPDATE mechanics
SET salary_id = mechanic_id
WHERE salary_id IS NULL;

-- 3. Véglegesítjük az egészet
COMMIT;