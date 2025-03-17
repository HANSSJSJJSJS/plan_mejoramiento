DELIMITER //
CREATE PROCEDURE InsertarTratamiento(
    IN p_medicamentos TEXT,
    IN p_recomendaciones TEXT,
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    INSERT INTO tratamientos (
        medicamentos, recomendaciones, consultas_medicas_id
    ) VALUES (
        p_medicamentos, p_recomendaciones, p_consultas_medicas_id
    );
    SELECT 'Tratamiento insertado correctamente' AS Mensaje;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE ObtenerTratamientoPorID(
    IN p_id INT
)
BEGIN
    SELECT * FROM tratamientos WHERE id = p_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerTratamientosPorConsultaMedica(
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    SELECT * FROM tratamientos WHERE consultas_medicas_id = p_consultas_medicas_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE MostrarTodosTratamientos()
BEGIN
    SELECT * FROM tratamientos;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarTratamiento(
    IN p_id INT,
    IN p_medicamentos TEXT,
    IN p_recomendaciones TEXT,
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    UPDATE tratamientos
    SET
        medicamentos = p_medicamentos,
        recomendaciones = p_recomendaciones,
        consultas_medicas_id = p_consultas_medicas_id
    WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Tratamiento actualizado correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró el tratamiento con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EliminarTratamiento(
    IN p_id INT
)
BEGIN
    DELETE FROM tratamientos WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Tratamiento eliminado correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró el tratamiento con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;