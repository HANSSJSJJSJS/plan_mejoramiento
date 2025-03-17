DELIMITER //
CREATE PROCEDURE InsertarAnamnesis(
    IN p_motivo_consulta TEXT,
    IN p_enfer_actual TEXT,
    IN p_antec_pers TEXT,
    IN p_antec_fam TEXT,
    IN p_habitos TEXT,
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    INSERT INTO anamnesis (
        motivo_consulta, enfer_actual, antec_pers, antec_fam, habitos, consultas_medicas_id
    ) VALUES (
        p_motivo_consulta, p_enfer_actual, p_antec_pers, p_antec_fam, p_habitos, p_consultas_medicas_id
    );
    SELECT 'Anamnesis insertada correctamente' AS Mensaje;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerAnamnesisPorID(
    IN p_id BIGINT
)
BEGIN
    SELECT * FROM anamnesis WHERE id = p_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerAnamnesisPorConsultaMedica(
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    SELECT * FROM anamnesis WHERE consultas_medicas_id = p_consultas_medicas_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE MostrarTodasAnamnesis()
BEGIN
    SELECT * FROM anamnesis;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarAnamnesis(
    IN p_id BIGINT,
    IN p_motivo_consulta TEXT,
    IN p_enfer_actual TEXT,
    IN p_antec_pers TEXT,
    IN p_antec_fam TEXT,
    IN p_habitos TEXT,
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    UPDATE anamnesis
    SET
        motivo_consulta = p_motivo_consulta,
        enfer_actual = p_enfer_actual,
        antec_pers = p_antec_pers,
        antec_fam = p_antec_fam,
        habitos = p_habitos,
        consultas_medicas_id = p_consultas_medicas_id
    WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Anamnesis actualizada correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró la anamnesis con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EliminarAnamnesis(
    IN p_id BIGINT
)
BEGIN
    DELETE FROM anamnesis WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Anamnesis eliminada correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró la anamnesis con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;

