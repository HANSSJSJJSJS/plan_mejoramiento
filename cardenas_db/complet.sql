CREATE DATABASE cardenas_db;
USE cardenas_db;

CREATE TABLE Aula (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(10) NOT NULL,
    planta ENUM('1', '2', '3', '4', '5') NOT NULL DEFAULT '1',
    situacion ENUM('DISPONIBLE', 'OCUPADA', 'EN MANTENIMIENTO') NOT NULL DEFAULT 'DISPONIBLE'
);

CREATE TABLE Estudiante (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    numero_matricula VARCHAR(50) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    direccion TEXT NOT NULL
);

CREATE TABLE Asignatura (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciclo ENUM('I', 'II', 'III') NOT NULL DEFAULT 'I',
    descripcion TEXT NOT NULL
);

CREATE TABLE Estudia (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    estudiante_id BIGINT UNSIGNED NOT NULL,
    asignatura_id BIGINT UNSIGNED NOT NULL,
    aula_id BIGINT UNSIGNED NOT NULL,
    hora TIME NOT NULL DEFAULT '08:00:00',
    FOREIGN KEY (estudiante_id) REFERENCES Estudiante(id) ON DELETE CASCADE,
    FOREIGN KEY (asignatura_id) REFERENCES Asignatura(id) ON DELETE CASCADE,
    FOREIGN KEY (aula_id) REFERENCES Aula(id) ON DELETE CASCADE
);


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

USE cardenas_db;

DELIMITER //

-- Insertar Aula
CREATE PROCEDURE InsertarAula(
    IN p_numero VARCHAR(10),
    IN p_planta INT,
    IN p_situacion ENUM('DISPONIBLE', 'OCUPADA', 'EN MANTENIMIENTO')
)
BEGIN
    INSERT INTO aula (numero, planta, situacion)
    VALUES (p_numero, COALESCE(p_planta, 1), COALESCE(p_situacion, 'DISPONIBLE'));
END //

-- Obtener Aula por Número
CREATE PROCEDURE ObtenerAulaPorNumero(
    IN p_numero VARCHAR(10)
)
BEGIN
    SELECT * FROM aula WHERE numero = p_numero;
END //

-- Mostrar todas las Aulas
CREATE PROCEDURE MostrarTodasAulas()
BEGIN
    SELECT * FROM aula;
END //

-- Actualizar Aula
CREATE PROCEDURE ActualizarAula(
    IN p_numero VARCHAR(10),
    IN p_planta INT,
    IN p_situacion ENUM('DISPONIBLE', 'OCUPADA', 'EN MANTENIMIENTO')
)
BEGIN
    UPDATE aula
    SET planta = COALESCE(p_planta, planta),
        situacion = COALESCE(p_situacion, situacion)
    WHERE numero = p_numero;
END //

-- Eliminar Aula
CREATE PROCEDURE EliminarAula(
    IN p_numero VARCHAR(10)
)
BEGIN
    DELETE FROM aula WHERE numero = p_numero;
END //

DELIMITER ;

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