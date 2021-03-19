-- FUNCTIONS

SET GLOBAL log_bin_trust_function_creators = 1;
USE gerenciadorPontos;

DELIMITER $$
	CREATE FUNCTION `fn_valida_email` (email VARCHAR(100)) RETURNS TINYINT
    BEGIN
		DECLARE retorno_email TINYINT DEFAULT 0;
        IF (email REGEXP '(^[a-z0-9._%-]+@[a-z0-9.-]+\.[a-z]{2,4}$)')
			THEN SET retorno_email  = 1;
        END IF;
        RETURN retorno_email;
    END$$
DELIMITER ;

