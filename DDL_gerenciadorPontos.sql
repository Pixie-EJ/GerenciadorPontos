/* modeloLogico_gerenciadorPontos: */
USE gerenciador_pontos;
CREATE TABLE users (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    email_verified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    password VARCHAR(255),
    enterprise_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE members (
    member_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    active BOOLEAN,
    role VARCHAR(80),
    enterprise_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE categories (
    category_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(35),
    description VARCHAR(80),
    enterprise_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE rules (
    rule_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    point INTEGER,
    enterprise_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE events (
    event_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(255),
    started_at DATETIME,
    ended_at DATETIME,
    category_id INTEGER,
    enterprise_id INTEGER,
    season_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE rules_categories (
    rule_category_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    active_ BOOLEAN,
    rule_id INTEGER,
    category_id INTEGER
);

CREATE TABLE events_members (
    event_member_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    member_id INTEGER,
    event_id INTEGER
);

CREATE TABLE enterprises (
    enterprise_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE teams (
    team_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    enterprise_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE teams_members (
    team_member_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    team_id INTEGER,
    member_id INTEGER
);

CREATE TABLE seasons (
	season_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(80),
    description VARCHAR(255),
    started_at TIMESTAMP,
    ended_at TIMESTAMP,
    enterprise_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE badges (
	badge_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    trophy BOOLEAN,
    name VARCHAR(80),
    description VARCHAR(255),
    enterprise_id INTEGER,
    season_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE badges_members (
	badges_members_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    badge_id INTEGER,
    member_id INTEGER
);
 
ALTER TABLE seasons ADD CONSTRAINT FK_season_enterprise
	FOREIGN KEY (enterprise_id)
    REFERENCES enterprises (enterprise_id)
    ON DELETE RESTRICT;
    
ALTER TABLE badges ADD CONSTRAINT FK_badge_enterprise
	FOREIGN KEY (enterprise_id)
    REFERENCES enterprises (enterprise_id)
    ON DELETE RESTRICT;
    
ALTER TABLE badges ADD CONSTRAINT FK_badge_season
	FOREIGN KEY (season_id)
    REFERENCES seasons (season_id)
    ON DELETE RESTRICT;
    
ALTER TABLE badges_members ADD CONSTRAINT FK_badge_member_badge
	FOREIGN KEY (badge_id)
    REFERENCES badges (badge_id)
    ON DELETE RESTRICT;

ALTER TABLE badges_members ADD CONSTRAINT FK_badge_member_member
	FOREIGN KEY (member_id)
    REFERENCES members (member_id)
    ON DELETE RESTRICT;

ALTER TABLE users ADD CONSTRAINT FK_users_enterprise
    FOREIGN KEY (enterprise_id)
    REFERENCES enterprises (enterprise_id)
    ON DELETE RESTRICT;
 
ALTER TABLE members ADD CONSTRAINT FK_members_enterprise
    FOREIGN KEY (enterprise_id)
    REFERENCES enterprises (enterprise_id)
    ON DELETE RESTRICT;
 
ALTER TABLE categories ADD CONSTRAINT FK_categories_enterprise
    FOREIGN KEY (enterprise_id)
    REFERENCES enterprises (enterprise_id)
    ON DELETE CASCADE;
 
ALTER TABLE rules ADD CONSTRAINT FK_rules_enterprise
    FOREIGN KEY (enterprise_id)
    REFERENCES enterprises (enterprise_id)
    ON DELETE CASCADE;
 
ALTER TABLE events ADD CONSTRAINT FK_events_category
    FOREIGN KEY (category_id)
    REFERENCES categories (category_id)
    ON DELETE CASCADE;
 
ALTER TABLE events ADD CONSTRAINT FK_events_enterprise
    FOREIGN KEY (enterprise_id)
    REFERENCES enterprises (enterprise_id)
    ON DELETE CASCADE;
 
ALTER TABLE events ADD CONSTRAINT FK_events_season
    FOREIGN KEY (season_id)
    REFERENCES seasons (season_id)
    ON DELETE CASCADE; 
 
ALTER TABLE rules_categories ADD CONSTRAINT FK_rules_categories_rule
    FOREIGN KEY (rule_id)
    REFERENCES rules (rule_id);
 
ALTER TABLE rules_categories ADD CONSTRAINT FK_rules_categories_category
    FOREIGN KEY (category_id)
    REFERENCES categories (category_id);
 
ALTER TABLE events_members ADD CONSTRAINT FK_events_members_member
    FOREIGN KEY (member_id)
    REFERENCES members (member_id);
 
ALTER TABLE events_members ADD CONSTRAINT FK_events_members_event
    FOREIGN KEY (event_id)
    REFERENCES events (event_id);
 
ALTER TABLE teams ADD CONSTRAINT FK_teams_enterprise
    FOREIGN KEY (enterprise_id)
    REFERENCES enterprises (enterprise_id)
    ON DELETE CASCADE;
 
ALTER TABLE teams_members ADD CONSTRAINT FK_teams_members_team
    FOREIGN KEY (team_id)
    REFERENCES teams (team_id);
 
ALTER TABLE teams_members ADD CONSTRAINT FK_teams_members_member
    FOREIGN KEY (member_id)
    REFERENCES members (member_id);