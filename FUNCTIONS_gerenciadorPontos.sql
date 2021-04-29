-- FUNCTIONS

SET GLOBAL log_bin_trust_function_creators = 1;
USE gerenciador_pontos;

DROP FUNCTION IF EXISTS fn_valida_email;
DELIMITER $$
	CREATE FUNCTION `fn_valida_email` (email VARCHAR(100)) RETURNS TINYINT
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