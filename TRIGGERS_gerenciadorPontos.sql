USE gerenciadorPontos;

DELIMITER $$
CREATE TRIGGER trg_ins_enterprise AFTER INSERT
ON enterprises
FOR EACH ROW
BEGIN
	UPDATE new.enterprise SET new.created_at = SYSDATE();
    UPDATE new.enterprise SET new.updated_at = SYSDATE();
    CALL prc_valida_email (new.email);
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER trg_upd_enterprise AFTER UPDATE
ON enterprises
FOR EACH ROW
BEGIN
    UPDATE new.enterprise SET new.updated_at = SYSDATE();
    CALL prc_valida_email (new.email);
END $$
DELIMITER ;

-- falta o delete enterprises, ainda não sei como tratar o delete

DELIMITER $$
CREATE TRIGGER trg_ins_members AFTER INSERT
ON members
FOR EACH ROW
BEGIN
	UPDATE new.members SET new.created_at = SYSDATE();
    UPDATE new.members SET new.updated_at = SYSDATE();
    CALL prc_valida_email (new.email);
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER trg_upd_members AFTER UPDATE
ON members
FOR EACH ROW
BEGIN
    UPDATE new.members SET new.updated_at = SYSDATE();
    CALL prc_valida_email (new.email);
END $$
DELIMITER ;

-- falta o delete members, ainda não sei como tratar o delete


