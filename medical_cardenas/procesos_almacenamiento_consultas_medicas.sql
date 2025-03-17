DELIMITER //
CREATE PROCEDURE InsertarConsultaMedica(
    IN p_fecha DATE,
    IN p_pacientes_id BIGINT,
    IN p_medicos_id BIGINT
)
BEGIN
    INSERT INTO consultas_medicas (fecha, pacientes_id, medicos_id)
    VALUES (p_fecha, p_pacientes_id, p_medicos_id);
    SELECT 'Consulta médica insertada correctamente' AS Mensaje;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE ObtenerConsultaMedicaPorID(
    IN p_id BIGINT
)
BEGIN
    SELECT * FROM consultas_medicas WHERE id = p_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerConsultasPorNombre(
    IN p_nombre VARCHAR(150)
)
BEGIN
    SELECT 
        cm.id AS consulta_id,
        cm.fecha,
        cm.pacientes_id,
        cm.medicos_id,
        p.usuarios_id AS paciente_usuario_id,
        u_p.first_name AS paciente_nombre,
        u_p.last_name AS paciente_apellido,
        m.usuarios_id AS medico_usuario_id,
        u_m.first_name AS medico_nombre,
        u_m.last_name AS medico_apellido
    FROM consultas_medicas cm
    JOIN pacientes p ON cm.pacientes_id = p.id
    JOIN usuarios u_p ON p.usuarios_id = u_p.id
    JOIN medicos m ON cm.medicos_id = m.id
    JOIN usuarios u_m ON m.usuarios_id = u_m.id
    WHERE u_p.first_name LIKE CONCAT('%', p_nombre, '%') 
    OR u_p.last_name LIKE CONCAT('%', p_nombre, '%')
    OR u_m.first_name LIKE CONCAT('%', p_nombre, '%')
    OR u_m.last_name LIKE CONCAT('%', p_nombre, '%');
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE MostrarTodasConsultasMedicas()
BEGIN
    SELECT * FROM consultas_medicas;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarConsultaMedica(
    IN p_id BIGINT,
    IN p_fecha DATE,
    IN p_pacientes_id BIGINT,
    IN p_medicos_id BIGINT
)
BEGIN
    UPDATE consultas_medicas
    SET
        fecha = p_fecha,
        pacientes_id = p_pacientes_id,
        medicos_id = p_medicos_id
    WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Consulta médica actualizada correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró la consulta médica con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE EliminarConsultaMedica(
    IN p_id BIGINT
)
BEGIN
    DELETE FROM consultas_medicas WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Consulta médica eliminada correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró la consulta médica con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;