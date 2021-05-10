USE gerenciador_pontos;
-- ------------- ENTERPRISES ------------ 
DROP TRIGGER IF EXISTS trg_ins_enterprise;
DELIMITER $$
CREATE TRIGGER trg_ins_enterprise AFTER INSERT
ON enterprises
FOR EACH ROW
BEGIN
    CALL prc_valida_email (new.email);
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_upd_enterprise;
DELIMITER $$
CREATE TRIGGER trg_upd_enterprise BEFORE UPDATE
ON enterprises
FOR EACH ROW
BEGIN
    SET new.updated_at = CURRENT_TIMESTAMP();
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
    CALL prc_valida_email (new.email);
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_upd_members;
DELIMITER $$
CREATE TRIGGER trg_upd_members BEFORE UPDATE
ON members
FOR EACH ROW
BEGIN
    SET new.updated_at = CURRENT_TIMESTAMP();
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
    CALL prc_valida_email (new.email);
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_upd_members;
DELIMITER $$
CREATE TRIGGER trg_upd_members BEFORE UPDATE
ON users
FOR EACH ROW
BEGIN
    SET new.updated_at = CURRENT_TIMESTAMP();
    CALL prc_valida_email (new.email);
END $$
DELIMITER ;

-- falta o delete members, ainda não sei como tratar o 
-- ------------- BADGES ------------
DROP TRIGGER IF EXISTS trg_upd_badges;
DELIMITER $$
CREATE TRIGGER trg_upd_badges BEFORE UPDATE
ON badges
FOR EACH ROW
BEGIN
    SET new.updated_at = CURRENT_TIMESTAMP();
END $$
DELIMITER ;

-- ------------- CATEGORIES ------------
DROP TRIGGER IF EXISTS trg_upd_categories;
DELIMITER $$
CREATE TRIGGER trg_upd_categories BEFORE UPDATE
ON categories
FOR EACH ROW
BEGIN
    SET new.updated_at = CURRENT_TIMESTAMP();
END $$
DELIMITER ;

-- ------------- BADGES ------------
DROP TRIGGER IF EXISTS trg_upd_badges;
DELIMITER $$
CREATE TRIGGER trg_upd_badges BEFORE UPDATE
ON badges
FOR EACH ROW
BEGIN
    SET new.updated_at = CURRENT_TIMESTAMP();
END $$
DELIMITER ;

-- ------------- EVENTS ------------
DROP TRIGGER IF EXISTS trg_ins_events;
DELIMITER $$
CREATE TRIGGER trg_ins_events AFTER INSERT
ON events
FOR EACH ROW
BEGIN
	CALL prc_valida_espaco_tempo (new.started_at,new.ended_at);
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_upd_events;
DELIMITER $$
CREATE TRIGGER trg_upd_events BEFORE UPDATE
ON events
FOR EACH ROW
BEGIN
    SET new.updated_at = CURRENT_TIMESTAMP();
END $$
DELIMITER ;

-- ------------- RULES ------------
DROP TRIGGER IF EXISTS trg_upd_rules;
DELIMITER $$
CREATE TRIGGER trg_upd_rules BEFORE UPDATE
ON rules
FOR EACH ROW
BEGIN
    SET new.updated_at = CURRENT_TIMESTAMP();
END $$
DELIMITER ;

-- ------------- SEASONS ------------
DROP TRIGGER IF EXISTS trg_ins_seasons;
DELIMITER $$
CREATE TRIGGER trg_ins_seasons AFTER INSERT
ON seasons
FOR EACH ROW
BEGIN
	CALL prc_valida_espaco_tempo (new.started_at,new.ended_at);
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_upd_seasons;
DELIMITER $$
CREATE TRIGGER trg_upd_seasons BEFORE UPDATE
ON seasons
FOR EACH ROW
BEGIN
    SET new.updated_at = CURRENT_TIMESTAMP();
END $$
DELIMITER ;

-- ------------- TEAMS ------------
DROP TRIGGER IF EXISTS trg_upd_teams;
DELIMITER $$
CREATE TRIGGER trg_upd_teams BEFORE UPDATE
ON teams
FOR EACH ROW
BEGIN
    SET new.updated_at = CURRENT_TIMESTAMP();
END $$
DELIMITER ;

/*-- ------------- EVENTS MEMBERS  ------------
DROP TRIGGER IF EXISTS trg_ins_events_members;
DELIMITER $$
CREATE TRIGGER trg_ins_events_members AFTER INSERT
ON events_members
FOR EACH ROW
BEGIN
	-- CALL prc_valida_mebro_evento (new.event_member_id,new.event_id, new.member_id);
END $$
DELIMITER ;*/
