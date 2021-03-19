-- FUNCTIONS

SET GLOBAL log_bin_trust_function_creators = 1;
USE gerenciador_pontos;

DROP FUNCTION IF EXISTS fn_valida_email;
DELIMITER $$
	CREATE FUNCTION `fn_valida_email` (email VARCHAR(255)) RETURNS TINYINT
    BEGIN
		DECLARE return_email TINYINT DEFAULT 0;
        IF (email REGEXP '(^[a-z0-9._%-]+@[a-z0-9.-]+\.[a-z]{2,4}$)')
			THEN SET return_email  = 1;
        END IF;
        RETURN return_email;
    END$$
DELIMITER ;

-- EVENTO/TEMPORADA NÃO PODE TER A DATA INICIAL MAIOR QUE A FINAL
DROP FUNCTION IF EXISTS fn_valida_espaco_tempo;
DELIMITER $$
	CREATE FUNCTION `fn_valida_espaco_tempo` (started_at TIMESTAMP, ended_at TIMESTAMP) RETURNS TINYINT
    BEGIN
		DECLARE return_date TINYINT DEFAULT 0;
        IF (ended_at >= started_at)
			THEN SET return_date  = 1;
        END IF;
        RETURN return_date;
    END$$
DELIMITER ;

-- OS NOVOS ESPAÇOES TEMPO NÃO PODEM ENCAVALAR   fn_presenca_membro_evento (old_envent_started_at, old_event_ended_at, new_envent_started_at, new_event_ended_at)
DROP FUNCTION IF EXISTS fn_presenca_membro_evento;
DELIMITER $$
	CREATE FUNCTION `fn_presenca_membro_evento` (old_envent_started_at TIMESTAMP, old_event_ended_at TIMESTAMP, new_envent_started_at TIMESTAMP, new_event_ended_at TIMESTAMP) RETURNS TINYINT
    BEGIN
		DECLARE return_valid_temp TINYINT DEFAULT 0;
        IF fn_valida_espaco_tempo (old_envent_started_at, old_event_ended_at) = 0 THEN
			RETURN 0;
        END IF;
        
        IF fn_valida_espaco_tempo (new_envent_started_at, new_event_ended_at) = 0 THEN
			RETURN 0;
        END IF;
        
        IF (new_envent_started_at <= old_envent_started_at)
			THEN IF (new_event_ended_at <= old_envent_started_at) THEN
					SET return_valid_temp  = 1;
                 END IF;
        END IF;
        
        IF (new_envent_started_at >= old_event_ended_at)
			THEN IF (new_event_ended_at >= old_event_ended_at) THEN
					SET return_valid_temp  = 1;
                 END IF;
        END IF;
        
        RETURN return_valid_temp;
    END$$
DELIMITER ;
