-- ====================================================================
-- JOGOSULTSÁGKEZELÉSI RENDSZER ÉLESÍTÉSE (Saját Docker környezetben)
-- ====================================================================
-- Leírás: Ez a szakasz létrehozza a szerepköröket (Roles), kiosztja a táblákhoz
-- tartozó jogosultságokat, majd létrehozza a tesztfelhasználókat (user1, user2).

-- 0. Kapcsolat módosítása a hagyományos nevek engedélyezéséhez (C## előtag megkerülése)
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;


-- ====================================================================
-- 1. SZEREPKÖRÖK (ROLES) LÉTREHOZÁSA
-- ====================================================================
CREATE ROLE ro_mechanic;
CREATE ROLE ro_storekeeper;


-- ====================================================================
-- 2. JOGOK KIOSZTÁSA A SZERELŐ SZEREPKÖRNEK (ro_mechanic)
-- ====================================================================
-- A szerelő felvehet új munkát, de a többi adatot csak olvashatja.

-- Írási és olvasási jog a munkákhoz:
GRANT SELECT, INSERT ON SZAMT14.jobs TO ro_mechanic;

-- Olvasási (adat-kikeresési) jogok a kapcsolódó szülőtáblákra:
GRANT SELECT ON SZAMT14.cars TO ro_mechanic;
GRANT SELECT ON SZAMT14.customers TO ro_mechanic;
GRANT SELECT ON SZAMT14.mechanics TO ro_mechanic;
GRANT SELECT ON SZAMT14.salaries TO ro_mechanic;
GRANT SELECT ON SZAMT14.operations TO ro_mechanic;
GRANT SELECT ON SZAMT14.parts TO ro_mechanic;
GRANT SELECT ON SZAMT14.parts_used TO ro_mechanic;
GRANT SELECT ON SZAMT14.field_jobs TO ro_mechanic;
GRANT SELECT ON SZAMT14.calendars TO ro_mechanic;


-- ====================================================================
-- 3. JOGOK KIOSZTÁSA A RAKTÁROS SZEREPKÖRNEK (ro_storekeeper)
-- ====================================================================
-- A raktáros kezeli az alkatrészeket és rendeléseket (olvashat, beszúrhat, módosíthat).

-- Teljes DML jog az alkatrész- és készletkezelő táblákra:
GRANT SELECT, INSERT, UPDATE ON SZAMT14.parts TO ro_storekeeper;
GRANT SELECT, INSERT, UPDATE ON SZAMT14.orders TO ro_storekeeper;
GRANT SELECT, INSERT, UPDATE ON SZAMT14.parts_orders TO ro_storekeeper;

-- Korlátozott olvasási jog a többi táblára az összefüggések látásához:
GRANT SELECT ON SZAMT14.jobs TO ro_storekeeper;
GRANT SELECT ON SZAMT14.parts_used TO ro_storekeeper;


-- ====================================================================
-- 4. FELHASZNÁLÓK LÉTREHOZÁSA ÉS SZEREPKÖRÖK HOZZÁRENDELÉSE
-- ====================================================================
CREATE USER user1 IDENTIFIED BY dummy1;
CREATE USER user2 IDENTIFIED BY dummy2;
Create user user3 identified by dummy3;

ALTER USER user1 IDENTIFIED BY User1_123;
ALTER USER user2 IDENTIFIED BY User2_456;
ALTER USER USER3 identified by User3_789;

-- Alapvető belépési (kapcsolódási) jog megadása:
GRANT CREATE SESSION TO user1;
GRANT CREATE SESSION TO user2;
GRANT create session to user3;

-- Szerepkörök (csoportok) ráhúzása a konkrét felhasználókra:
GRANT ro_mechanic TO user1;
GRANT ro_storekeeper TO user2;
GRANT ro_storekeeper to user3;


-- ====================================================================
-- 5. PUBLIKUS SZINONIMÁK (Hogy ne kelljen kiírni a "SZAMT14." előtagot)
-- ====================================================================
CREATE PUBLIC SYNONYM jobs FOR SZAMT14.jobs;
CREATE PUBLIC SYNONYM cars FOR SZAMT14.cars;
CREATE PUBLIC SYNONYM parts FOR SZAMT14.parts;
CREATE PUBLIC SYNONYM orders FOR SZAMT14.orders;
CREATE PUBLIC SYNONYM parts_orders FOR SZAMT14.parts_orders;