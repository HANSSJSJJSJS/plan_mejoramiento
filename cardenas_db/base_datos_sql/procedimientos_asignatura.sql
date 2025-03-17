USE cardenas_db;
-- Procedimientos para la tabla Asignatura
DELIMITER //
-- Procedimiento para insertar una asignatura
CREATE PROCEDURE InsertarAsignatura(
    IN p_nombre VARCHAR(100),
    IN p_ciclo ENUM('I', 'II', 'III'),
    IN p_descripcion TEXT
)
BEGIN
    INSERT INTO Asignatura (nombre, ciclo, descripcion)
    VALUES (p_nombre, p_ciclo, p_descripcion);
    SELECT 'Asignatura insertada correctamente' AS Mensaje;
END //


DELIMITER //
-- Procedimiento para obtener una asignatura por nombre
CREATE PROCEDURE ObtenerAsignaturaPorNombre(
    IN p_nombre VARCHAR(100)
)
BEGIN
    SELECT * FROM Asignatura WHERE nombre LIKE CONCAT('%', p_nombre, '%');
END //


DELIMITER //
-- Procedimiento para obtener una asignatura por ID
CREATE PROCEDURE ObtenerAsignaturaPorID(
    IN p_id BIGINT UNSIGNED
)
BEGIN
    SELECT * FROM Asignatura WHERE id = p_id;
END //


DELIMITER //
-- Procedimiento para mostrar todas las asignaturas
CREATE PROCEDURE MostrarTodasAsignaturas()
BEGIN
    SELECT * FROM Asignatura;
END //


DELIMITER //
-- Procedimiento para actualizar una asignatura
CREATE PROCEDURE ActualizarAsignatura(
    IN p_id BIGINT UNSIGNED,
    IN p_nombre VARCHAR(100),
    IN p_ciclo ENUM('I', 'II', 'III'),
    IN p_descripcion TEXT
)
BEGIN
    UPDATE Asignatura 
    SET nombre = p_nombre, 
        ciclo = p_ciclo,
        descripcion = p_descripcion
    WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Asignatura actualizada correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró la asignatura con el ID proporcionado' AS Mensaje;
    END IF;
END //


DELIMITER //
-- Procedimiento para eliminar una asignatura y registros relacionados
CREATE PROCEDURE EliminarAsignatura(
    IN p_id BIGINT UNSIGNED
)
BEGIN
    DELETE FROM Estudia WHERE asignatura_id = p_id;
    DELETE FROM Asignatura WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Asignatura eliminada correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró la asignatura con el ID proporcionado' AS Mensaje;
    END IF;
END //

DELIMITER ;