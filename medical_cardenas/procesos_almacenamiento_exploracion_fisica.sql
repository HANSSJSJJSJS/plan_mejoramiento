DELIMITER //
CREATE PROCEDURE InsertarExploracionFisica(
    IN p_pre_arterial VARCHAR(50),
    IN p_frec_cardiaca INT,
    IN p_temp DECIMAL(4,2),
    IN p_peso DECIMAL(5,2),
    IN p_hallazgos TEXT,
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    INSERT INTO exploraciones_fisicas (
        pre_arterial, frec_cardiaca, temp, peso, hallazgos, consultas_medicas_id
    ) VALUES (
        p_pre_arterial, p_frec_cardiaca, p_temp, p_peso, p_hallazgos, p_consultas_medicas_id
    );
    SELECT 'Exploración física insertada correctamente' AS Mensaje;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerExploracionFisicaPorID(
    IN p_id BIGINT
)
BEGIN
    SELECT * FROM exploraciones_fisicas WHERE id = p_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerExploracionesPorConsultaMedica(
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    SELECT * FROM exploraciones_fisicas WHERE consultas_medicas_id = p_consultas_medicas_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE MostrarTodasExploracionesFisicas()
BEGIN
    SELECT * FROM exploraciones_fisicas;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarExploracionFisica(
    IN p_id BIGINT,
    IN p_pre_arterial VARCHAR(50),
    IN p_frec_cardiaca INT,
    IN p_temp DECIMAL(4,2),
    IN p_peso DECIMAL(5,2),
    IN p_hallazgos TEXT,
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    UPDATE exploraciones_fisicas
    SET
        pre_arterial = p_pre_arterial,
        frec_cardiaca = p_frec_cardiaca,
        temp = p_temp,
        peso = p_peso,
        hallazgos = p_hallazgos,
        consultas_medicas_id = p_consultas_medicas_id
    WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Exploración física actualizada correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró la exploración física con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE EliminarExploracionFisica(
    IN p_id BIGINT
)
BEGIN
    DELETE FROM exploraciones_fisicas WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Exploración física eliminada correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró la exploración física con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;