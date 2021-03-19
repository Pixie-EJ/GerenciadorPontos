--PROCEDURES
USE gerenciadorPontos;

DELIMITER $$
	CREATE PROCEDURE `prc_valida_email`(email VARCHAR(60))
    BEGIN
		IF fn_valida_email(email) = 0
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'E-mail inválido';
        END IF;
    END $$
DELIMITER ;

DELIMITER $$
	CREATE PROCEDURE `prc_add_enterprise`(p_name VARCHAR(50), p_email VARCHAR(80))
    BEGIN	
        INSERT INTO interprises(`name`, email) 
        VALUES (p_name, p_email);
    END $$
DELIMITER ;

DELIMITER $$
	CREATE PROCEDURE `prc_add_category`(p_name VARCHAR(50), p_description VARCHAR(300), p_interprise_id INTEGER)
    BEGIN	
        INSERT INTO categories(`name`, `description`, fk_enterprises_enterprise_id) 
        VALUES (p_name, p_description, p_interprise_id);
    END $$
DELIMITER ;

DELIMITER $$
	CREATE PROCEDURE `prc_add_event`(p_name VARCHAR(50), p_description VARCHAR(300), p_started_at TIMESTAMP, p_ended_at TIMESTAMP, p_category_id INTEGER, p_interprise_id INTEGER)
    BEGIN	
        INSERT INTO `events`(`name`, `description`, started_at, ended_at, fk_categories_category_id, fk_enterprises_enterprise_id) 
        VALUES (p_name, p_description, p_started_at, p_ended_at, p_category_id, p_interprise_id);
    END $$
DELIMITER ;

DELIMITER $$
	CREATE PROCEDURE `prc_add_member_into_event`(p_member_id INTEGER, p_event_id INTEGER)
    BEGIN	
        INSERT INTO categories(fk_members_member_id , fk_events_event_id) 
        VALUES (p_member_id, p_event_id);
    END $$
DELIMITER ;

DELIMITER $$
	CREATE PROCEDURE `prc_add_member`(p_name VARCHAR(50), p_email VARCHAR(50), p_active TINYINT, p_role VARCHAR(80), p_interprise_id INTEGER)
    BEGIN	
        INSERT INTO members(`name`, email, `active`, `role`, fk_enterprises_enterprise_id) 
        VALUES (p_name, p_email, p_active, p_role, p_interprise_id);
    END $$
DELIMITER ;

DELIMITER $$
	CREATE PROCEDURE `prc_add_rule`(p_name VARCHAR(50), p_point INTEGER, p_interprise_id INTEGER)
    BEGIN	
        INSERT INTO rules(`name`, email, fk_enterprises_enterprise_id) 
        VALUES (p_name, p_email, p_interprise_id);
    END $$
DELIMITER ;

DELIMITER $$
	CREATE PROCEDURE `prc_add_rule_into_category`(p_active VARCHAR(50), p_rule_id INTEGER, p_category_id INTEGER)
    BEGIN	
        INSERT INTO rules_categories_belongsToMany(`name`, fk_rules_rule_id, fk_categories_category_id) 
        VALUES (p_name, p_rule_id, p_category_id);
    END $$
DELIMITER ;

DELIMITER $$
	CREATE PROCEDURE `prc_add_team`(p_name VARCHAR(50), p_interprise_id INTEGER)
    BEGIN	
        INSERT INTO teams(`name`, fk_enterprises_enterprise_id) 
        VALUES (p_name, p_interprise_id);
    END $$
DELIMITER ;

DELIMITER $$
	CREATE PROCEDURE `prc_add_member_into_team`(p_team_id INTEGER, p_member_id INTEGER)
    BEGIN	
        INSERT INTO teams_members_belongsToMany(fk_team_team_id, fk_members_member_id) 
        VALUES (p_team_id, p_member_id);
    END $$
DELIMITER ;

DELIMITER $$
	CREATE PROCEDURE `prc_add_user`(p_name_id INTEGER, p_email VARCHAR(50), p_password VARCHAR(255), p_interprise_id INTEGER)
    BEGIN	
        INSERT INTO users(`name`, email, `password`, fk_enterprises_enterprise_id) 
        VALUES (p_name_id, p_email, p_password, p_interprise_id);
    END $$
DELIMITER ;