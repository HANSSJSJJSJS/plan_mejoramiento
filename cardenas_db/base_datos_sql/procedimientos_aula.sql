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
