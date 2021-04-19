USE gerenciador_pontos;
-- ------------- ENTERPRISES ------------ 
DROP TRIGGER IF EXISTS trg_ins_enterprise;
DELIMITER $$
CREATE TRIGGER trg_ins_enterprise AFTER INSERT
ON enterprises
FOR EACH ROW
BEGIN
    UPDATE new.enterprise SET new.updated_at = SYSDATE();
    CALL prc_valida_email (new.email);
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_upd_enterprise;
DELIMITER $$
CREATE TRIGGER trg_upd_enterprise AFTER UPDATE
ON enterprises
FOR EACH ROW
BEGIN
    UPDATE new.enterprise SET new.updated_at = SYSDATE();
    CALL prc_valida_email (new.email);
END $$
DELIMITER ;

-- falta o delete enterprises, ainda não sei como tratar o delete


-- ------------- MEMBERS ------------

DROP TRIGGER IF EXISTS trg_ins_members;
DELIMITER $$
CREATE TRIGGER trg_ins_members AFTER INSERT
ON members
FOR EACH ROW
BEGIN
    UPDATE new.members SET new.updated_at = SYSDATE();
    CALL prc_valida_email (new.email);
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_upd_members;
DELIMITER $$
CREATE TRIGGER trg_upd_members AFTER UPDATE
ON members
FOR EACH ROW
BEGIN
    UPDATE new.members SET new.updated_at = SYSDATE();
    CALL prc_valida_email (new.email);
END $$
DELIMITER ;

-- falta o delete members, ainda não sei como tratar o 

-- ------------- USERS ------------
DROP TRIGGER IF EXISTS trg_ins_users;
DELIMITER $$
CREATE TRIGGER trg_ins_users AFTER INSERT
ON users
FOR EACH ROW
BEGIN
    UPDATE new.users SET new.updated_at = SYSDATE();
    CALL prc_valida_email (new.email);
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_upd_members;
DELIMITER $$
CREATE TRIGGER trg_upd_members AFTER UPDATE
ON users
FOR EACH ROW
BEGIN
    UPDATE new.users SET new.updated_at = SYSDATE();
    CALL prc_valida_email (new.email);
END $$
DELIMITER ;

-- falta o delete members, ainda não sei como tratar o 
-- ------------- BADGES ------------
DROP TRIGGER IF EXISTS trg_upd_badges;
DELIMITER $$
CREATE TRIGGER trg_upd_badges AFTER UPDATE
ON badges
FOR EACH ROW
BEGIN
    UPDATE new.badges SET new.updated_at = SYSDATE();
END $$
DELIMITER ;

-- ------------- CATEGORIES ------------
DROP TRIGGER IF EXISTS trg_upd_categories;
DELIMITER $$
CREATE TRIGGER trg_upd_categories AFTER UPDATE
ON categories
FOR EACH ROW
BEGIN
    UPDATE new.categories SET new.updated_at = SYSDATE();
END $$
DELIMITER ;

-- ------------- BADGES ------------
DROP TRIGGER IF EXISTS trg_upd_badges;
DELIMITER $$
CREATE TRIGGER trg_upd_badges AFTER UPDATE
ON badges
FOR EACH ROW
BEGIN
    UPDATE new.badges SET new.updated_at = SYSDATE();
END $$
DELIMITER ;

-- ------------- EVENTS ------------
DROP TRIGGER IF EXISTS trg_upd_events;
DELIMITER $$
CREATE TRIGGER trg_upd_events AFTER UPDATE
ON events
FOR EACH ROW
BEGIN
    UPDATE new.events SET new.updated_at = SYSDATE();
END $$
DELIMITER ;

-- ------------- RULES ------------
DROP TRIGGER IF EXISTS trg_upd_rules;
DELIMITER $$
CREATE TRIGGER trg_upd_rules AFTER UPDATE
ON rules
FOR EACH ROW
BEGIN
    UPDATE new.rules SET new.updated_at = SYSDATE();
END $$
DELIMITER ;

-- ------------- SEASONS ------------
DROP TRIGGER IF EXISTS trg_upd_seasons;
DELIMITER $$
CREATE TRIGGER trg_upd_seasons AFTER UPDATE
ON seasons
FOR EACH ROW
BEGIN
    UPDATE new.seasons SET new.updated_at = SYSDATE();
END $$
DELIMITER ;

-- ------------- TEAMS ------------
DROP TRIGGER IF EXISTS trg_upd_teams;
DELIMITER $$
CREATE TRIGGER trg_upd_teams AFTER UPDATE
ON teams
FOR EACH ROW
BEGIN
    UPDATE new.teams SET new.updated_at = SYSDATE();
END $$
DELIMITER ;
