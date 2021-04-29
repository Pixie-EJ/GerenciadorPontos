-- PROCEDURES
USE gerenciador_pontos;

DROP PROCEDURE IF EXISTS prc_valida_email;
DELIMITER $$
	CREATE PROCEDURE `prc_valida_email`(email VARCHAR(60))
    BEGIN
		IF fn_valida_email(email) = 0
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'E-mail inválido';
        END IF;
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_valida_espaco_tempo;
DELIMITER $$
	CREATE PROCEDURE `prc_valida_espaco_tempo`(started_at TIMESTAMP, ended_at TIMESTAMP)
    BEGIN
		IF fn_valida_espaco_tempo(started_at, ended_at) = 0
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Espaço tempo não é válido!';
        END IF;
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_valida_mebro_evento;
DELIMITER $$
	CREATE PROCEDURE `prc_valida_mebro_evento`(p_event_member_id INTEGER, p_event_id INTEGER, p_member_id INTEGER)
    BEGIN
    
		DECLARE valid_member_event TINYINT DEFAULT 1;
        DECLARE v_event_id INTEGER;
        DECLARE v_event_member_id INTEGER;
        DECLARE old_envent_started_at TIMESTAMP;
        DECLARE old_event_ended_at TIMESTAMP;
        DECLARE new_envent_started_at TIMESTAMP;
        DECLARE new_event_ended_at TIMESTAMP;
        DECLARE end_loop TINYINT DEFAULT 0;
        DECLARE how_many_events INTEGER;
		DECLARE c_events CURSOR	FOR 
			SELECT em.event_member_id, ev.started_at, ev.ended_at, ev.event_id
			FROM events ev
            JOIN events_members em
            ON ev.event_id = em.fk_events_event_id
			JOIN seasons s
			ON ev.fk_seasons_season_id = s.season_id
			WHERE ev.started_at BETWEEN s.started_at AND s.ended_at
			AND ev.ended_at BETWEEN s.started_at AND s.ended_at;
            OPEN c_events;
       
		SELECT count(ev.event_id) 
			INTO how_many_events
            FROM events ev
            JOIN events_members em
            ON ev.event_id = em.fk_events_event_id
			JOIN seasons s
			ON ev.fk_seasons_season_id = s.season_id
			WHERE ev.started_at BETWEEN s.started_at AND s.ended_at
			AND ev.ended_at BETWEEN s.started_at AND s.ended_at;
		
        SELECT ev.started_at, ev.ended_at
            INTO new_envent_started_at, new_event_ended_at
            FROM events ev
            WHERE ev.event_id = p_event_id;
            
		-- SET v_event_member_id 
            
		events_loop: LOOP
			SET end_loop = end_loop + 1;
            FETCH c_events INTO v_event_member_id, old_envent_started_at, old_event_ended_at, v_event_id;
            SET valid_member_event = fn_presenca_membro_evento (old_envent_started_at, old_event_ended_at, new_envent_started_at, new_event_ended_at);
            
			 select old_envent_started_at,old_event_ended_at,v_event_id,v_event_member_id, valid_member_event;
            IF  v_event_id = p_event_id OR v_event_member_id = p_event_member_id THEN
				SET valid_member_event = 1;
            END if;
            IF end_loop = how_many_events OR valid_member_event = 0 THEN
					LEAVE events_loop;
			END IF;
		END LOOP;
        CLOSE c_events;
		IF valid_member_event = 0 THEN 
			DELETE FROM events_members WHERE event_member_id = p_event_member_id;
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Esse usuário já está alocado num evento no mesmo horário!';
        END IF;
    END $$
DELIMITER ;

/*
-- sempre que um membro for alocado num evento deve ser consultado se ele está presente em um evento na mesma data
DROP PROCEDURE IF EXISTS prc_valida_member_envent;
DELIMITER $$
	CREATE PROCEDURE `prc_valida_member_envent`(p_trophy BOOLEAN, p_name VARCHAR(50), p_description VARCHAR(255), p_enterprise_id INTEGER, p_season_id INTEGER)
	BEGIN
		IF fn_presenca_unica_evento(started_at, ended_at) = 0
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Espaço tempo não é válido!';
        END IF;
	END $$
DELIMITER ;*/

DROP PROCEDURE IF EXISTS prc_add_badges;
DELIMITER $$
	CREATE PROCEDURE `prc_add_badges`(p_trophy BOOLEAN, p_name VARCHAR(50), p_description VARCHAR(255), p_enterprise_id INTEGER, p_season_id INTEGER)
	BEGIN
		INSERT INTO badges(trophy, name, description, fk_enterprises_enterprise_id, fk_seasons_season_id) 
        VALUES (p_trophy, p_name, p_description, p_enterprise_id, p_season_id);
        COMMIT;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_badges_members;
DELIMITER $$
	CREATE PROCEDURE `prc_add_badges_members`(p_badge_id INTEGER, p_member_id INTEGER)
	BEGIN
		INSERT INTO badges_members(fk_badges_members_badge_id, fk_badges_members_member_id)
        VALUES (p_badge_id, p_member_id);
        COMMIT;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_category;
DELIMITER $$
	CREATE PROCEDURE `prc_add_category`(p_name VARCHAR(50), p_description VARCHAR(300), p_interprise_id INTEGER)
    BEGIN	
        INSERT INTO categories(name, description, fk_enterprises_enterprise_id) 
        VALUES (p_name, p_description, p_interprise_id);
        COMMIT;
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_enterprises;
DELIMITER $$
	CREATE PROCEDURE `prc_add_enterprises`(p_name VARCHAR(50), p_email VARCHAR(80))
    BEGIN	
        INSERT INTO enterprises(name, email) 
        VALUES (p_name, p_email);
        COMMIT;
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_event;
DELIMITER $$
	CREATE PROCEDURE `prc_add_event`(p_name VARCHAR(50), p_description VARCHAR(300), p_started_at TIMESTAMP, p_ended_at TIMESTAMP, p_category_id INTEGER, p_interprise_id INTEGER, p_season_id INTEGER)
    BEGIN	
        INSERT INTO events(name, description, started_at, ended_at, fk_categories_category_id, fk_enterprises_enterprise_id, fk_seasons_season_id) 
        VALUES (p_name, p_description, p_started_at, p_ended_at, p_category_id, p_interprise_id, p_season_id);
        COMMIT;
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_member;
DELIMITER $$
	CREATE PROCEDURE `prc_add_member`(p_name VARCHAR(50), p_email VARCHAR(50), p_active TINYINT, p_role VARCHAR(80), p_interprise_id INTEGER)
    BEGIN	
        INSERT INTO members(name, email, active, role, fk_enterprises_enterprise_id) 
        VALUES (p_name, p_email, p_active, p_role, p_interprise_id);
        COMMIT;
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_events_members;
DELIMITER $$
	CREATE PROCEDURE `prc_add_events_members`(p_member_id INTEGER, p_event_id INTEGER)
    BEGIN	
        INSERT INTO events_members(fk_members_member_id , fk_events_event_id) 
        VALUES (p_member_id, p_event_id);
        COMMIT;
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_rule;
DELIMITER $$
	CREATE PROCEDURE `prc_add_rule`(p_name VARCHAR(50), p_point INTEGER, p_interprise_id INTEGER)
    BEGIN	
        INSERT INTO rules(name, email, fk_enterprises_enterprise_id) 
        VALUES (p_name, p_email, p_interprise_id);
        COMMIT;
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_rules_categories;
DELIMITER $$
	CREATE PROCEDURE `prc_add_rules_categories`(p_active VARCHAR(50), p_rule_id INTEGER, p_category_id INTEGER)
    BEGIN	
        INSERT INTO rules_categories(name, fk_rules_rule_id, fk_categories_category_id) 
        VALUES (p_name, p_rule_id, p_category_id);
        COMMIT;
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_seasons;
DELIMITER $$
	CREATE PROCEDURE `prc_add_seasons`( p_name VARCHAR(80), p_description VARCHAR(255), p_started_at TIMESTAMP, p_ended_at TIMESTAMP, p_enterprise_id INTEGER)
	BEGIN
		INSERT INTO seasons ( name, description, started_at, ended_at, fk_enterprises_enterprise_id)
        VALUES ( p_name, p_description, p_started_at, p_ended_at, p_enterprise_id);
        COMMIT;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_teams;
DELIMITER $$
	CREATE PROCEDURE `prc_add_teams`(p_name VARCHAR(50), p_interprise_id INTEGER)
    BEGIN	
        INSERT INTO teams(name, fk_enterprises_enterprise_id) 
        VALUES (p_name, p_interprise_id);
        COMMIT;
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_teams_members;
DELIMITER $$
	CREATE PROCEDURE `prc_add_teams_members`(p_team_id INTEGER, p_member_id INTEGER)
    BEGIN	
        INSERT INTO teams_members(fk_team_team_id, fk_members_member_id) 
        VALUES (p_team_id, p_member_id);
        COMMIT;
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_users;
DELIMITER $$
	CREATE PROCEDURE `prc_add_users`(p_name_id INTEGER, p_email VARCHAR(50), p_password VARCHAR(255), p_interprise_id INTEGER)
    BEGIN	
        INSERT INTO users(name, email, password, fk_enterprises_enterprise_id) 
        VALUES (p_name_id, p_email, p_password, p_interprise_id);
        COMMIT;
    END $$
DELIMITER ;