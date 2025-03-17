USE cardenas_db;

DELIMITER //

-- Procedimiento para insertar un estudiante
CREATE PROCEDURE InsertarEstudiante(
    IN p_numero_matricula VARCHAR(50),
    IN p_nombre VARCHAR(100),
    IN p_direccion TEXT
)
BEGIN
    INSERT INTO Estudiante (numero_matricula, nombre, direccion)
    VALUES (p_numero_matricula, p_nombre, p_direccion);
    SELECT 'Estudiante insertado correctamente' AS Mensaje;
END //


DELIMITER //
-- Procedimiento para obtener un estudiante por nombre
CREATE PROCEDURE ObtenerEstudiantePorNombre(
    IN p_nombre VARCHAR(100)
)
BEGIN
    SELECT * FROM Estudiante WHERE nombre LIKE CONCAT('%', p_nombre, '%');
END //


DELIMITER //
-- Procedimiento para obtener un estudiante por ID
CREATE PROCEDURE ObtenerEstudiantePorID(
    IN p_id BIGINT UNSIGNED
)
BEGIN
    SELECT * FROM Estudiante WHERE id = p_id;
END //


DELIMITER //
-- Procedimiento para mostrar todos los estudiantes
CREATE PROCEDURE MostrarTodosEstudiantes()
BEGIN
    SELECT * FROM Estudiante;
END //


DELIMITER //
-- Procedimiento para actualizar un estudiante
CREATE PROCEDURE ActualizarEstudiante(
    IN p_id BIGINT UNSIGNED,
    IN p_numero_matricula VARCHAR(50),
    IN p_nombre VARCHAR(100),
    IN p_direccion TEXT
)
BEGIN
    UPDATE Estudiante 
    SET numero_matricula = p_numero_matricula, 
        nombre = p_nombre,
        direccion = p_direccion
    WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Estudiante actualizado correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró el estudiante con el ID proporcionado' AS Mensaje;
    END IF;
END //


DELIMITER //
-- Procedimiento para eliminar un estudiante y registros relacionados
CREATE PROCEDURE EliminarEstudiante(
    IN p_id BIGINT UNSIGNED
)
BEGIN
    DELETE FROM Estudia WHERE estudiante_id = p_id;
    DELETE FROM Estudiante WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Estudiante eliminado correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró el estudiante con el ID proporcionado' AS Mensaje;
    END IF;
END //

DELIMITER ;