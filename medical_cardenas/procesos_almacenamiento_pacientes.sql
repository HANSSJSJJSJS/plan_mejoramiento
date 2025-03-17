DELIMITER //
CREATE PROCEDURE InsertarPaciente(
    IN p_genero ENUM('M', 'F'),
    IN p_usuarios_id BIGINT
)
BEGIN
    INSERT INTO pacientes (genero, usuarios_id)
    VALUES (p_genero, p_usuarios_id);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE ObtenerPacientePorID(
    IN p_id BIGINT
)
BEGIN
    SELECT * FROM pacientes WHERE id = p_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerPacientePorNombre(
    IN p_nombre VARCHAR(150)
)
BEGIN
    SELECT 
        p.id AS paciente_id,
        p.genero,
        p.usuarios_id,
        u.username AS nombre_usuario,
        u.first_name AS nombre,
        u.last_name AS apellido,
        u.email,
        u.telefono,
        u.direccion
    FROM pacientes p
    JOIN usuarios u ON p.usuarios_id = u.id
    WHERE u.first_name LIKE CONCAT('%', p_nombre, '%') 
    OR u.last_name LIKE CONCAT('%', p_nombre, '%');
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE MostrarTodosPacientes()
BEGIN
    SELECT * FROM pacientes;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarPaciente(
    IN p_id BIGINT,
    IN p_genero ENUM('M', 'F'),
    IN p_usuarios_id BIGINT
)
BEGIN
    UPDATE pacientes
    SET
        genero = p_genero,
        usuarios_id = p_usuarios_id
    WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Paciente actualizado correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró el paciente con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE EliminarPaciente(
    IN p_id BIGINT
)
BEGIN
    DELETE FROM pacientes WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Paciente eliminado correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró el paciente con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;