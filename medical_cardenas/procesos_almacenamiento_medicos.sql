-- ------------------------------------------------------procesos de almacenamiento MEDICOS
DELIMITER //
CREATE PROCEDURE InsertarMedico(
    IN p_carnet VARCHAR(45),
    IN p_especialidad VARCHAR(45),
    IN p_usuarios_id BIGINT
)
BEGIN
    INSERT INTO medicos (carnet, especialidad, usuarios_id)
    VALUES (p_carnet, p_especialidad, p_usuarios_id);
    SELECT 'Médico insertado correctamente' AS Mensaje;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerMedicoPorID(
    IN p_id BIGINT
)
BEGIN
    SELECT * FROM medicos WHERE id = p_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerMedicoPorNombre(
    IN p_nombre VARCHAR(150)
)
BEGIN
    SELECT 
        m.id AS medico_id,
        m.carnet,
        m.especialidad,
        m.usuarios_id,
        u.username AS nombre_usuario,
        u.first_name AS nombre,
        u.last_name AS apellido
    FROM medicos m
    JOIN usuarios u ON m.usuarios_id = u.id
    WHERE u.first_name LIKE CONCAT('%', p_nombre, '%') 
       OR u.last_name LIKE CONCAT('%', p_nombre, '%');
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE MostrarTodosMedicos()
BEGIN
    SELECT * FROM medicos;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarMedico(
    IN p_id BIGINT,
    IN p_carnet VARCHAR(45),
    IN p_especialidad VARCHAR(45),
    IN p_usuarios_id BIGINT
)
BEGIN
    UPDATE medicos
    SET
        carnet = p_carnet,
        especialidad = p_especialidad,
        usuarios_id = p_usuarios_id
    WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Médico actualizado correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró el médico con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EliminarMedico(
    IN p_id BIGINT
)
BEGIN
    DELETE FROM medicos WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Médico eliminado correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró el médico con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;