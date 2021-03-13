/* modeloLogico_gerenciadorPontos: */

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    email_verified_at TIMESTAMP,
    password VARCHAR(255),
    fk_enterprises_enterprise_id INTEGER,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE TABLE members (
    member_id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    active BOOLEAN,
    role VARCHAR(80),
    fk_enterprises_enterprise_id INTEGER,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE TABLE categories (
    category_id INTEGER PRIMARY KEY,
    name VARCHAR(35),
    description VARCHAR(80),
    fk_enterprises_enterprise_id INTEGER,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE TABLE rules (
    rule_id INTEGER PRIMARY KEY,
    name VARCHAR(30),
    point INTEGER,
    fk_enterprises_enterprise_id INTEGER,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE TABLE events (
    event_id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(255),
    started_at DATETIME,
    ended_at DATETIME,
    fk_categories_category_id INTEGER,
    fk_enterprises_enterprise_id INTEGER,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE TABLE rules_categories_belongsToMany (
    rule_category_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    active_ BOOLEAN,
    fk_rules_rule_id INTEGER,
    fk_categories_category_id INTEGER
);

CREATE TABLE events_members_belongsToMany (
    event_member_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    fk_members_member_id INTEGER,
    fk_events_event_id INTEGER
);

CREATE TABLE enterprises (
    enterprise_id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE TABLE teams (
    team_id INTEGER PRIMARY KEY,
    name VARCHAR(30),
    fk_enterprises_enterprise_id INTEGER,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE TABLE teams_members_belongsToMany (
    team_member_id INTEGER PRIMARY KEY,
    fk_teams_team_id INTEGER,
    fk_members_member_id INTEGER
);
 
ALTER TABLE users ADD CONSTRAINT FK_users_2
    FOREIGN KEY (fk_enterprises_enterprise_id)
    REFERENCES enterprises (enterprise_id)
    ON DELETE RESTRICT;
 
ALTER TABLE members ADD CONSTRAINT FK_members_2
    FOREIGN KEY (fk_enterprises_enterprise_id)
    REFERENCES enterprises (enterprise_id)
    ON DELETE RESTRICT;
 
ALTER TABLE categories ADD CONSTRAINT FK_categories_2
    FOREIGN KEY (fk_enterprises_enterprise_id)
    REFERENCES enterprises (enterprise_id)
    ON DELETE CASCADE;
 
ALTER TABLE rules ADD CONSTRAINT FK_rules_2
    FOREIGN KEY (fk_enterprises_enterprise_id)
    REFERENCES enterprises (enterprise_id)
    ON DELETE CASCADE;
 
ALTER TABLE events ADD CONSTRAINT FK_events_2
    FOREIGN KEY (fk_categories_category_id)
    REFERENCES categories (category_id)
    ON DELETE CASCADE;
 
ALTER TABLE events ADD CONSTRAINT FK_events_3
    FOREIGN KEY (fk_enterprises_enterprise_id)
    REFERENCES enterprises (enterprise_id)
    ON DELETE CASCADE;
 
ALTER TABLE rules_categories_belongsToMany ADD CONSTRAINT FK_rules_categories_belongsToMany_2
    FOREIGN KEY (fk_rules_rule_id)
    REFERENCES rules (rule_id);
 
ALTER TABLE rules_categories_belongsToMany ADD CONSTRAINT FK_rules_categories_belongsToMany_3
    FOREIGN KEY (fk_categories_category_id)
    REFERENCES categories (category_id);
 
ALTER TABLE events_members_belongsToMany ADD CONSTRAINT FK_events_members_belongsToMany_2
    FOREIGN KEY (fk_members_member_id)
    REFERENCES members (member_id);
 
ALTER TABLE events_members_belongsToMany ADD CONSTRAINT FK_events_members_belongsToMany_3
    FOREIGN KEY (fk_events_event_id)
    REFERENCES events (event_id);
 
ALTER TABLE teams ADD CONSTRAINT FK_teams_2
    FOREIGN KEY (fk_enterprises_enterprise_id)
    REFERENCES enterprises (enterprise_id)
    ON DELETE CASCADE;
 
ALTER TABLE teams_members_belongsToMany ADD CONSTRAINT FK_teams_members_belongsToMany_2
    FOREIGN KEY (fk_teams_team_id)
    REFERENCES teams (team_id);
 
ALTER TABLE teams_members_belongsToMany ADD CONSTRAINT FK_teams_members_belongsToMany_3
    FOREIGN KEY (fk_members_member_id)
    REFERENCES members (member_id);