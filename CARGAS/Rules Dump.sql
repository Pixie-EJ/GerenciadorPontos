-- AULA / SCRUM MEETING
INSERT INTO `gerenciador_pontos`.`rules` (`name`, `point`, `has_multiplier`, `enterprises_id`)
VALUES ('Não participação', -30, false, 1);

INSERT INTO `gerenciador_pontos`.`rules` (`name`, `point`, `has_multiplier`, `enterprises_id`)
VALUES ('Entrada atrasada ou saída antecipada', 10, false, 1);

INSERT INTO `gerenciador_pontos`.`rules` (`name`, `point`, `has_multiplier`, `enterprises_id`)
VALUES ('Entrada e saída no horário', 15, false, 1);

INSERT INTO `gerenciador_pontos`.`rules` (`name`, `point`, `has_multiplier`, `enterprises_id`)
VALUES ('Por pergunta respondida', 5, true, 1);

-- TASK
INSERT INTO `gerenciador_pontos`.`rules` (`name`, `point`, `has_multiplier`, `enterprises_id`)
VALUES ('Participação em task', 30, false, 1);

INSERT INTO `gerenciador_pontos`.`rules` (`name`, `point`, `has_multiplier`, `enterprises_id`)
VALUES ('Não participação em task', -30, false, 1);

-- CURSO POR FORA
INSERT INTO `gerenciador_pontos`.`rules` (`name`, `point`, `has_multiplier`, `enterprises_id`)
VALUES ('A cada 6h de curso finalizado', -30, false, 1);

-- EVENTO
INSERT INTO `gerenciador_pontos`.`rules` (`name`, `point`, `has_multiplier`, `enterprises_id`)
VALUES ('Por dia de participação em evento', 20, true, 1);


INSERT INTO `gerenciador_pontos`.`rules` (`name`, `point`, `has_multiplier`, `enterprises_id`)
VALUES ('Por dia de atraso em evento', 10, true, 1);
