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

DROP PROCEDURE IF EXISTS prc_valida_membro_evento;
DELIMITER $$
	CREATE PROCEDURE `prc_valida_membro_evento`(p_event_member_id INTEGER, p_event_id INTEGER, p_member_id INTEGER)
    BEGIN
		DECLARE valid_member_event TINYINT DEFAULT 1;
        DECLARE v_event_id INTEGER;
        DECLARE v_event_member_id INTEGER;
        DECLARE old_event_started_at TIMESTAMP;
        DECLARE old_event_ended_at TIMESTAMP;
        DECLARE new_event_started_at TIMESTAMP;
        DECLARE new_event_ended_at TIMESTAMP;
        DECLARE end_loop TINYINT DEFAULT 0;
        DECLARE how_many_events INTEGER;
		DECLARE c_events_members CURSOR	FOR 
			SELECT ev.started_at, ev.ended_at, ev.id
			FROM events ev
			JOIN seasons s
			ON ev.seasons_id = s.id
            JOIN events_members em
            ON ev.id = em.events_id
            JOIN members m
            on m.id = em.members_id
            where m.id = p_member_id;
            OPEN c_events_members;
       
		SELECT count(ev.id) 
			INTO how_many_events
            FROM events ev
			JOIN seasons s
			ON ev.seasons_id = s.id
			WHERE ev.id = p_event_id;
		
        SELECT ev.started_at, ev.ended_at
            INTO new_event_started_at, new_event_ended_at
            FROM events ev
            WHERE ev.id = p_event_id;
            
		events_loop: LOOP
			SET end_loop = end_loop + 1;
            
            FETCH c_events_members INTO old_event_started_at, old_event_ended_at, v_event_id;
            
            SET valid_member_event = fn_presenca_membro_evento (old_event_started_at, old_event_ended_at, new_event_started_at, new_event_ended_at);
            
            IF  v_event_id = p_event_id THEN
				SET valid_member_event = 1;
            END if;
            
            IF end_loop = how_many_events OR valid_member_event = 0 THEN
					LEAVE events_loop;
			END IF;
		END LOOP;
        CLOSE c_events_members;
		IF valid_member_event = 0 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Esse usuário já está alocado num evento no mesmo horário!';
        END IF;
	CREATE PROCEDURE `prc_add_enterprises`(p_name VARCHAR(50), p_email VARCHAR(80))
    BEGIN	
        INSERT INTO enterprises(`name`, email, created_at, updated_at, deleted_at) 
        VALUES (p_name, p_email, "0000-00-00 00:00:00","0000-00-00 00:00:00","0000-00-00 00:00:00");
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_badges;
DELIMITER $$
	CREATE PROCEDURE `prc_add_badges`(p_trophy BOOLEAN, p_name VARCHAR(50), p_description VARCHAR(80), p_enterprise_id INTEGER, p_season_id INTEGER)
	BEGIN
		INSERT INTO badges(trophy, name, description, enterprises_id, seasons_id) 
        VALUES (p_trophy, p_name, p_description, p_enterprise_id, p_season_id);
        COMMIT;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_badges_members;
DELIMITER $$
	CREATE PROCEDURE `prc_add_badges_members`(p_badge_id INTEGER, p_member_id INTEGER)
	BEGIN
		INSERT INTO badges_members(badges_id, members_id)
        VALUES (p_badge_id, p_member_id);
        COMMIT;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_category;
DELIMITER $$
	CREATE PROCEDURE `prc_add_category`(p_name VARCHAR(50), p_description VARCHAR(300), p_interprise_id INTEGER)
    BEGIN	
        INSERT INTO categories(name, description, enterprises_id) 
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
        INSERT INTO events(name, description, started_at, ended_at, categories_id, enterprises_id, seasons_id) 
        VALUES (p_name, p_description, p_started_at, p_ended_at, p_category_id, p_interprise_id, p_season_id);
        COMMIT;
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_member;
DELIMITER $$
	CREATE PROCEDURE `prc_add_member`(p_name VARCHAR(50), p_email VARCHAR(50), p_active TINYINT, p_role VARCHAR(80), p_interprise_id INTEGER)
    BEGIN	
        INSERT INTO members(name, email, active, role, enterprises_id) 
        VALUES (p_name, p_email, p_active, p_role, p_interprise_id);
        COMMIT;
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_events_members;
DELIMITER $$
	CREATE PROCEDURE `prc_add_events_members`(p_member_id INTEGER, p_event_id INTEGER)
    BEGIN	
        INSERT INTO events_members(members_id , events_id) 
        VALUES (p_member_id, p_event_id);
        COMMIT;
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_rule;
DELIMITER $$
	CREATE PROCEDURE `prc_add_rule`(p_name VARCHAR(50), p_point INTEGER, p_interprise_id INTEGER)
    BEGIN	
        INSERT INTO rules(name, point, enterprises_id) 
        VALUES (p_name, p_point, p_interprise_id);
        COMMIT;
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_rules_categories;
DELIMITER $$
	CREATE PROCEDURE `prc_add_rules_categories`(p_active TINYINT, p_rule_id INTEGER, p_category_id INTEGER)
    BEGIN	
        INSERT INTO rules_categories(active_, rules_id, categories_id) 
        VALUES (p_active, p_rule_id, p_category_id);
        COMMIT;
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_seasons;
DELIMITER $$
	CREATE PROCEDURE `prc_add_seasons`( p_name VARCHAR(80), p_description VARCHAR(255), p_started_at TIMESTAMP, p_ended_at TIMESTAMP, p_enterprise_id INTEGER)
	BEGIN
		INSERT INTO seasons ( name, description, started_at, ended_at, enterprises_id)
        VALUES ( p_name, p_description, p_started_at, p_ended_at, p_enterprise_id);
        COMMIT;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_teams;
DELIMITER $$
	CREATE PROCEDURE `prc_add_teams`(p_name VARCHAR(50), p_interprise_id INTEGER)
    BEGIN	
        INSERT INTO teams(name, enterprises_id) 
        VALUES (p_name, p_interprise_id);
        COMMIT;
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_teams_members;
DELIMITER $$
	CREATE PROCEDURE `prc_add_teams_members`(p_team_id INTEGER, p_member_id INTEGER)
    BEGIN	
        INSERT INTO teams_members(teams_id, members_id) 
        VALUES (p_team_id, p_member_id);
        COMMIT;
    END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS prc_add_users;
DELIMITER $$
	CREATE PROCEDURE `prc_add_users`(p_name_id VARCHAR(255), p_email VARCHAR(255), p_password VARCHAR(255), p_interprise_id INTEGER)
    BEGIN	
        INSERT INTO users(name, email, password, enterprises_id) 
        VALUES (p_name_id, p_email, p_password, p_interprise_id);
        COMMIT;
    END $$
DELIMITER ;