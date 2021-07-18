CREATE DATABASE gerenciador_pontos;
USE gerenciador_pontos;
CREATE TABLE users (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    email_verified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    password VARCHAR(255),
    enterprises_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE members (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    active BOOLEAN,
    role VARCHAR(80),
    enterprises_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE categories (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(35),
    description VARCHAR(80),
    enterprises_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE rules (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(60),
    point INTEGER,
    has_multiplier BOOLEAN,
    enterprises_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE events (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(255),
    started_at DATETIME,
    ended_at DATETIME,
    categories_id INTEGER NULL DEFAULT NULL,
    enterprises_id INTEGER NULL DEFAULT NULL,
    seasons_id INTEGER NULL DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE rules_categories (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    active_ BOOLEAN,
    rules_id INTEGER,
    categories_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE events_members (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    members_id INTEGER,
    events_id INTEGER
);

CREATE TABLE enterprises (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE teams (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    enterprises_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE teams_members (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    teams_id INTEGER,
    members_id INTEGER
);

CREATE TABLE seasons (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(80),
    description VARCHAR(255),
    started_at TIMESTAMP,
    ended_at TIMESTAMP,
    enterprises_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE badges (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    trophy BOOLEAN,
    name VARCHAR(80),
    description VARCHAR(255),
    enterprises_id INTEGER,
    seasons_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE badges_members (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    badges_id INTEGER,
    members_id INTEGER
);

CREATE TABLE scores (
    score_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    multiplier_value INTEGER,
    members_id INTEGER,
    events_id INTEGER,
    categories_id INTEGER,
    rules_id INTEGER,
	  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    deleted_at TIMESTAMP NULL DEFAULT NULL
);
 
ALTER TABLE seasons ADD CONSTRAINT FK_season_enterprise
	FOREIGN KEY (enterprises_id)
    REFERENCES enterprises (id)
    ON DELETE RESTRICT;
    
ALTER TABLE badges ADD CONSTRAINT FK_badge_enterprise
	FOREIGN KEY (enterprises_id)
    REFERENCES enterprises (id)
    ON DELETE RESTRICT;
    
ALTER TABLE badges ADD CONSTRAINT FK_badge_season
	FOREIGN KEY (seasons_id)
    REFERENCES seasons (id)
    ON DELETE RESTRICT;
    
ALTER TABLE badges_members ADD CONSTRAINT FK_badge_member_badge
	FOREIGN KEY (badges_id)
    REFERENCES badges (id)
    ON DELETE RESTRICT;

ALTER TABLE badges_members ADD CONSTRAINT FK_badge_member_member
	FOREIGN KEY (members_id)
    REFERENCES members (id)
    ON DELETE RESTRICT;

ALTER TABLE users ADD CONSTRAINT FK_users_enterprise
    FOREIGN KEY (enterprises_id)
    REFERENCES enterprises (id)
    ON DELETE RESTRICT;
 
ALTER TABLE members ADD CONSTRAINT FK_members_enterprise
    FOREIGN KEY (enterprises_id)
    REFERENCES enterprises (id)
    ON DELETE RESTRICT;
 
ALTER TABLE categories ADD CONSTRAINT FK_categories_enterprise
    FOREIGN KEY (enterprises_id)
    REFERENCES enterprises (id)
    ON DELETE CASCADE;
 
ALTER TABLE rules ADD CONSTRAINT FK_rules_enterprise
    FOREIGN KEY (enterprises_id)
    REFERENCES enterprises (id)
    ON DELETE CASCADE;
 
ALTER TABLE events ADD CONSTRAINT FK_events_category
    FOREIGN KEY (categories_id)
    REFERENCES categories (id)
    ON DELETE CASCADE;
 
ALTER TABLE events ADD CONSTRAINT FK_events_enterprise
    FOREIGN KEY (enterprises_id)
    REFERENCES enterprises (id)
    ON DELETE CASCADE;
 
ALTER TABLE events ADD CONSTRAINT FK_events_season
    FOREIGN KEY (seasons_id)
    REFERENCES seasons (id)
    ON DELETE CASCADE; 
 
ALTER TABLE rules_categories ADD CONSTRAINT FK_rules_categories_rule
    FOREIGN KEY (rules_id)
    REFERENCES rules (id);
 
ALTER TABLE rules_categories ADD CONSTRAINT FK_rules_categories_category
    FOREIGN KEY (categories_id)
    REFERENCES categories (id);
 
ALTER TABLE events_members ADD CONSTRAINT FK_events_members_member
    FOREIGN KEY (members_id)
    REFERENCES members (id);
 
ALTER TABLE events_members ADD CONSTRAINT FK_events_members_event
    FOREIGN KEY (events_id)
    REFERENCES events (id);
 
ALTER TABLE teams ADD CONSTRAINT FK_teams_enterprise
    FOREIGN KEY (enterprises_id)
    REFERENCES enterprises (id)
    ON DELETE CASCADE;
 
ALTER TABLE teams_members ADD CONSTRAINT FK_teams_members_team
    FOREIGN KEY (teams_id)
    REFERENCES teams (id);
 
ALTER TABLE teams_members ADD CONSTRAINT FK_teams_members_member
    FOREIGN KEY (members_id)
    REFERENCES members (id);
    
ALTER TABLE scores ADD CONSTRAINT FK_scores_2
    FOREIGN KEY (members_id)
    REFERENCES members (id)
    ON DELETE CASCADE;
 
ALTER TABLE scores ADD CONSTRAINT FK_scores_3
    FOREIGN KEY (events_id)
    REFERENCES events (id)
    ON DELETE CASCADE;
 
ALTER TABLE scores ADD CONSTRAINT FK_scores_4
    FOREIGN KEY (categories_id)
    REFERENCES categories (id)
    ON DELETE CASCADE;
 
ALTER TABLE scores ADD CONSTRAINT FK_scores_5
    FOREIGN KEY (rules_id)
    REFERENCES rules (id)
    ON DELETE CASCADE;