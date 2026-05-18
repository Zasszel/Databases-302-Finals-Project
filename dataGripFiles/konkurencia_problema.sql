--Teszt vegett egyre allitsuk az id=1 alaktreszt
UPDATE parts SET quantity = 2 WHERE part_id = 1;
COMMIT;

DECLARE
    v_current_stock NUMBER;
    v_part_id NUMBER := 1; -- A kiválasztott fékbetét
BEGIN
    -- 1. LÉPÉS: Lekérjük a készletet, DE a "FOR UPDATE" paranccsal lelakatoljuk a sort!
    -- Amíg ez a tranzakció fut, senki más nem nyúlhat ehhez az alkatrészhez.
    SELECT quantity
    INTO v_current_stock
    FROM parts
    WHERE part_id = v_part_id
    FOR UPDATE;

    -- 2. LÉPÉS: Ellenőrizzük, hogy van-e még belőle
    IF v_current_stock >= 1 THEN
        -- Ha van, csökkentjük a készletet 1-gyel
        UPDATE parts
        SET quantity = quantity - 1
        WHERE part_id = v_part_id;

        DBMS_OUTPUT.PUT_LINE('Sikeres vásárlás! Készlet csökkentve.');

        -- Itt véglegesítjük (feloldja a lakatot)
        COMMIT;
    ELSE
        -- Ha már időközben elvitték, hibát dobunk és nem engedjük mínuszba menni
        DBMS_OUTPUT.PUT_LINE('Hiba: Az alkatrész időközben elfogyott!');
        ROLLBACK;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK; -- Bármilyen hiba esetén visszavonjuk és feloldjuk a zárat
        RAISE;
END;
/
commit;