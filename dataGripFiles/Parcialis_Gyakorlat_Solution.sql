--Main function:
--Fitnesz termek beosztasa:
--      parameterek: pEdzoID, pSzolgID, pTeremID, pNap


--1.Function
--Adott edzo (pEdzoID) tarte olyan kurzust,
-- melyen az adott szolgaltatast (pSzolgID) igenybe lehet venni:
    -- return:
        -- -1 -> ha nincs.


--2.Function
--Ha tart ilyen kurzust:
    -- keressunk egy idopontot, amikor a megadott napon (pNap) szabad,
        -- mind az edzo (pEdzoID), mint a megadott terem (pTeremID).
            -- -> Irja ki a legelsot amit megtalal.
--!!!!Egy edzo nem tarthat 4 kurzusnal tobbet egy nap (minden kurzus 1 oras).

--Ha nem talaltunk ilyen idopontot a megadott napon (pNap)
-- => keresunk egy olyan napot amikor van a felteteleknek megfelelo idopont.

    -- return:
            -- az idopont (Ora) - ha nincs az adott napon megfelelo idopont (ha keresnunk kellett).
            -- 0 - ha kaptunk megfelelo idopontot es helyszint + szurjunk be az orarend tablaba.

-- Termek(TeremID, Emelet)
-- Edzők(EdzőID, ENév, ETfSzám)
-- Szolgáltatások(SzolgID,SzNév)
-- EdzőSzolgáltat(ESzID, EdzőID, SzolgID)
-- Órarend(ID, ESzID, TeremID, Nap, Óra)


--1.Function
-- Input: pEdzoID, pSzolgID;
-- Output: 0 or 1;
select * from EDZOK;
select * from SZOLGALTATASOK;
select * from EDZOSZOLGALTAT;
select * from termek;
select * from ORAREND;

create or replace function doTrainerCourse(pEdzoID in EDZOK.EDZOID%type, pSzolgID in SZOLGALTATASOK.SZOLGID%type)
return number
is
    v_temp number;
begin
    select ESZID into v_temp
    from EDZOSZOLGALTAT
        where EDZOID = pEdzoID and SZOLGID = pSzolgID;
    return v_temp;
    exception
        when NO_DATA_FOUND then return -1;
end;

begin
    DBMS_OUTPUT.PUT_LINE(doTrainerCourse(1,'KS'));
end;
/
--Count classes/trainer/day if > or <= 4.
create or replace function trainerDailyHourLessThanFour (pNap in ORAREND.NAP%type, pEdzoID in EDZOK.EDZOID%type)
return number
is
    dailyHourCnt number;
begin
    select count(*) into dailyHourCnt
    from EDZOSZOLGALTAT e join ORAREND o
    on e.ESZID = o.ESZID
    where EDZOID = pEdzoID and NAP = pNap;

    if (dailyHourCnt < 4) then
        return 1;
    else
        return 0;
    end if;
end;

-- select *
-- from EDZOSZOLGALTAT e join ORAREND o
-- on e.ESZID = o.ESZID;
-- select count(*)
-- from EDZOSZOLGALTAT e join ORAREND o
-- on e.ESZID = o.ESZID
-- where EDZOID = 1 and NAP = 1;
select *
from EDZOSZOLGALTAT e join ORAREND o
on e.ESZID = o.ESZID
where EDZOID = 1 and NAP = 1 and TEREMID = 1;
/
--A time when both trainer and room is free on the given day\
select * from ORAREND;
select *
from EDZOSZOLGALTAT e join ORAREND o
on e.ESZID = o.ESZID;

create or replace function dayIsTrainerAndRoomFree(
    pEdzoID in EDZOK.EDZOID%type,
    pTeremID in TERMEK.TEREMID%type,
    pNap in ORAREND.NAP%type,
    pSzolgID in SZOLGALTATASOK.SZOLGID%type
)
return number
is
    v_utkozes number;
begin
    if (trainerDailyHourLessThanFour(pNap => pNap, pEdzoID => pEdzoID) = 1) then
        return -1;
    end if;
    for v_ora in 8 .. 18 loop
        --utkozes kereses
        select count(*) into v_utkozes
        from ORAREND o
        join EDZOSZOLGALTAT e
        on o.ESZID = e.ESZID
        where NAP = pNap and  ORA = v_ora and ( --ha kap orat az adott napon -> van utkozes, viszont:
            o.TEREMID = pTeremID --ha adott napon adott oraban kap ugyanazt a termet -> meg mindig utkozik -> nem szabad az idopont; ha nem kap -> a terem meg szabad lehet abban az oraban:
            or e.EDZOID = pEdzoID --ha kap edzot ugyanabban az oraba -> utkozes -> nem szabad az idopont; ha nem kap -> az edzo is szabad lehet abban az oraban csak mas teremben:
            or e.SZOLGID = pSzolgID -- ha kapja ugyanazt a szolgaltatast (elozoleg leellenorizzuk, igy itt biztosan tudjuk hogy az edzo tartja azt a szolgaltatast) -> mar fut ilyen szolgaltatas az adott oraban.
            );

        --nem tortent utkozes -> talaltunk egy szabad helyet:
        if (v_utkozes = 0) then
            return v_ora;
        end if;

    end loop;

    return -1;

end;
/
CREATE OR REPLACE FUNCTION fitneszTermekBeosztas(
    pEdzoID IN edzok.EDZOID%type,
    pSzolgID IN SZOLGALTATASOK.SZOLGID%type,
    pTeremID IN TERMEK.TEREMID%type,
    pNap IN ORAREND.NAP%type
)
RETURN NUMBER
IS
    v_dayIsTrainerAndRoomFree NUMBER;
    v_EszID NUMBER;
BEGIN
    -- 1. Ellenőrizzük, oktatja-e a szolgáltatást (:= operátorral)
    v_EszID := doTrainerCourse(pEdzoID => pEdzoID, pSzolgID => pSzolgID);

    IF (v_EszID = -1) THEN
        RETURN -1;
    END IF;

    -- 2. Megnézzük a kért napot
    v_dayIsTrainerAndRoomFree := dayIsTrainerAndRoomFree(
            pEdzoID => pEdzoID,
            pTeremID => pTeremID,
            pNap => pNap,
            pSzolgID => pSzolgID
    );

    -- 3. Ha az eredeti napon nincs hely
    IF (v_dayIsTrainerAndRoomFree = -1) THEN
        DBMS_OUTPUT.PUT_LINE('Nem talaltunk idpontot a ' || pNap || '. napon, viszont keresunk egy masik napon.');

        FOR v_nap IN 1 .. 7 LOOP
             v_dayIsTrainerAndRoomFree := dayIsTrainerAndRoomFree(
                pEdzoID => pEdzoID,
                pTeremID => pTeremID,
                pNap => v_nap, -- A ciklusváltozót (v_nap) adjuk át!
                pSzolgID => pSzolgID
            );

            IF (v_dayIsTrainerAndRoomFree != -1) THEN
                DBMS_OUTPUT.PUT_LINE('Idopont talalat a(z) ' || v_nap || '. napon a(z) ' || v_dayIsTrainerAndRoomFree || '. oraban.');
                -- A feladat szerint alternatív napnál maga az óra a visszatérítési érték
                RETURN v_dayIsTrainerAndRoomFree;
            END IF;
        END LOOP;

        -- Ha a ciklus végigért, és az egész héten nincs hely:
        DBMS_OUTPUT.PUT_LINE('Sajnos ezen a heten mar egyaltalan nincs szabad idopont.');
        RETURN -1;

    END IF;

    -- 4. Ha volt hely az eredeti napon, akkor beszúrjuk és 0-val térünk vissza
    INSERT INTO ORAREND(ID, ESZID, TEREMID, NAP, ORA)
    VALUES (
            (SELECT NVL(MAX(ID), 0) + 1 FROM ORAREND), -- Üres tábla védelem
            v_EszID,
            pTeremID,
            pNap,
            v_dayIsTrainerAndRoomFree
           );

    RETURN 0;
END;
select * from orarend;