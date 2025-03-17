DELIMITER //
CREATE PROCEDURE InsertarHistorialClinico(
    IN p_fecha_consulta DATE,
    IN p_motivo_consulta TEXT,
    IN p_diagnostico TEXT,
    IN p_tratamiento TEXT,
    IN p_pacientes_id BIGINT,
    IN p_medicos_id BIGINT
)
BEGIN
    INSERT INTO historiales_clinicos (
        fecha_consulta, motivo_consulta, diagnostico, tratamiento, pacientes_id, medicos_id
    ) VALUES (
        p_fecha_consulta, p_motivo_consulta, p_diagnostico, p_tratamiento, p_pacientes_id, p_medicos_id
    );
    SELECT 'Historial clínico insertado correctamente' AS Mensaje;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE ObtenerHistorialClinicoPorID(
    IN p_id BIGINT
)
BEGIN
    SELECT * FROM historiales_clinicos WHERE id = p_id;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE ObtenerHistorialesPorNombre(
    IN p_nombre VARCHAR(150)
)
BEGIN
    SELECT 
        hc.id AS historial_id,
        hc.fecha_consulta,
        hc.motivo_consulta,
        hc.diagnostico,
        hc.tratamiento,
        hc.pacientes_id,
        hc.medicos_id,
        p.usuarios_id AS paciente_usuario_id,
        u_p.first_name AS paciente_nombre,
        u_p.last_name AS paciente_apellido,
        m.usuarios_id AS medico_usuario_id,
        u_m.first_name AS medico_nombre,
        u_m.last_name AS medico_apellido
    FROM historiales_clinicos hc
    JOIN pacientes p ON hc.pacientes_id = p.id
    JOIN usuarios u_p ON p.usuarios_id = u_p.id
    JOIN medicos m ON hc.medicos_id = m.id
    JOIN usuarios u_m ON m.usuarios_id = u_m.id
    WHERE u_p.first_name LIKE CONCAT('%', p_nombre, '%') 
    OR u_p.last_name LIKE CONCAT('%', p_nombre, '%')
    OR u_m.first_name LIKE CONCAT('%', p_nombre, '%')
    OR u_m.last_name LIKE CONCAT('%', p_nombre, '%');
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE MostrarTodosHistorialesClinicos()
BEGIN
    SELECT * FROM historiales_clinicos;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE ActualizarHistorialClinico(
    IN p_id BIGINT,
    IN p_fecha_consulta DATE,
    IN p_motivo_consulta TEXT,
    IN p_diagnostico TEXT,
    IN p_tratamiento TEXT,
    IN p_pacientes_id BIGINT,
    IN p_medicos_id BIGINT
)
BEGIN
    UPDATE historiales_clinicos
    SET
        fecha_consulta = p_fecha_consulta,
        motivo_consulta = p_motivo_consulta,
        diagnostico = p_diagnostico,
        tratamiento = p_tratamiento,
        pacientes_id = p_pacientes_id,
        medicos_id = p_medicos_id
    WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Historial clínico actualizado correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró el historial clínico con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE EliminarHistorialClinico(
    IN p_id BIGINT
)
BEGIN
    DELETE FROM historiales_clinicos WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Historial clínico eliminado correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró el historial clínico con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;