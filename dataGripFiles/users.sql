CREATE TABLE app_users (
    user_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR2(50) UNIQUE NOT NULL,
    password VARCHAR2(100) NOT NULL, -- Élesben ez egy titkosított (hash) karakterlánc lenne
    role VARCHAR2(20) CHECK (role IN ('ADMIN', 'MECHANIC', 'STOREKEEPER')) NOT NULL
);

-- 2. Tesztfelhasználók beszúrása

--admin
INSERT INTO app_users (username, password, role)
VALUES ('szamt14', 'admin_secure_pass', 'ADMIN');

--
INSERT INTO app_users (username, password, role)
VALUES ('kovacs_janos', 'janos123', 'MECHANIC');

-- Nagy Gábor, a raktáros
-- (Alkalmazás szinten: 'parts', 'orders' és 'parts_orders' SELECT, INSERT, UPDATE)
INSERT INTO app_users (username, password, role)
VALUES ('nagy_gabor', 'gabor123', 'STOREKEEPER');

-- Véglegesítjük a felhasználókat
COMMIT;