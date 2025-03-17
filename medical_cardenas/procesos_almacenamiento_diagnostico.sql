DELIMITER //
CREATE PROCEDURE InsertarDiagnostico(
    IN p_descripcion TEXT,
    IN p_codigo_cie VARCHAR(20),
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    INSERT INTO diagnostico (
        descripcion, codigo_cie, consultas_medicas_id
    ) VALUES (
        p_descripcion, p_codigo_cie, p_consultas_medicas_id
    );
    SELECT 'Diagnóstico insertado correctamente' AS Mensaje;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerDiagnosticoPorID(
    IN p_id BIGINT
)
BEGIN
    SELECT * FROM diagnostico WHERE id = p_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerDiagnosticosPorConsultaMedica(
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    SELECT * FROM diagnostico WHERE consultas_medicas_id = p_consultas_medicas_id;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE MostrarTodosDiagnosticos()
BEGIN
    SELECT * FROM diagnostico;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarDiagnostico(
    IN p_id BIGINT,
    IN p_descripcion TEXT,
    IN p_codigo_cie VARCHAR(20),
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    UPDATE diagnostico
    SET
        descripcion = p_descripcion,
        codigo_cie = p_codigo_cie,
        consultas_medicas_id = p_consultas_medicas_id
    WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Diagnóstico actualizado correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró el diagnóstico con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EliminarDiagnostico(
    IN p_id BIGINT
)
BEGIN
    DELETE FROM diagnostico WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Diagnóstico eliminado correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró el diagnóstico con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;

