

-- ------------------------------------------------------------------proceso de almacenamiento USUARIOS
DELIMITER //
CREATE PROCEDURE InsertarUsuario(
    IN p_password VARCHAR(128),
    IN p_last_login DATETIME,
    IN p_is_superuser TINYINT,
    IN p_username VARCHAR(150),
    IN p_first_name VARCHAR(45),
    IN p_last_name VARCHAR(45),
    IN p_email VARCHAR(254),
    IN p_is_staff TINYINT,
    IN p_is_active TINYINT,
    IN p_date_joined DATETIME,
    IN p_tipo_doc ENUM('CC', 'CE'),
    IN p_num_doc VARCHAR(20),
    IN p_fecha_nac DATE,
    IN p_ciudad_nac VARCHAR(100),
    IN p_direccion VARCHAR(100),
    IN p_telefono VARCHAR(100),
    IN p_imagen VARCHAR(100)
)
BEGIN
    INSERT INTO usuarios (
        password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, tipo_doc, num_doc, fecha_nac, ciudad_nac, direccion, telefono, imagen
    ) VALUES (
        p_password, p_last_login, p_is_superuser, p_username, p_first_name, p_last_name, p_email, p_is_staff, p_is_active, p_date_joined, p_tipo_doc, p_num_doc, p_fecha_nac, p_ciudad_nac, p_direccion, p_telefono, p_imagen
    );
    SELECT 'Usuario insertado correctamente' AS Mensaje;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerUsuarioPorID(
    IN p_id BIGINT
)
BEGIN
    SELECT * FROM usuarios WHERE id = p_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerUsuarioPorNombre(
    IN p_nombre VARCHAR(150)
)
BEGIN
    SELECT * FROM usuarios WHERE username LIKE CONCAT('%', p_nombre, '%');
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE MostrarTodosUsuarios()
BEGIN
    SELECT * FROM usuarios;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarUsuario(
    IN p_id BIGINT,
    IN p_password VARCHAR(128),
    IN p_last_login DATETIME,
    IN p_is_superuser TINYINT,
    IN p_username VARCHAR(150),
    IN p_first_name VARCHAR(45),
    IN p_last_name VARCHAR(45),
    IN p_email VARCHAR(254),
    IN p_is_staff TINYINT,
    IN p_is_active TINYINT,
    IN p_date_joined DATETIME,
    IN p_tipo_doc ENUM('CC', 'CE'),
    IN p_num_doc VARCHAR(20),
    IN p_fecha_nac DATE,
    IN p_ciudad_nac VARCHAR(100),
    IN p_direccion VARCHAR(100),
    IN p_telefono VARCHAR(100),
    IN p_imagen VARCHAR(100)
)
BEGIN
    UPDATE usuarios
    SET
        password = p_password,
        last_login = p_last_login,
        is_superuser = p_is_superuser,
        username = p_username,
        first_name = p_first_name,
        last_name = p_last_name,
        email = p_email,
        is_staff = p_is_staff,
        is_active = p_is_active,
        date_joined = p_date_joined,
        tipo_doc = p_tipo_doc,
        num_doc = p_num_doc,
        fecha_nac = p_fecha_nac,
        ciudad_nac = p_ciudad_nac,
        direccion = p_direccion,
        telefono = p_telefono,
        imagen = p_imagen
    WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Usuario actualizado correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró el usuario con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EliminarUsuario(
    IN p_id BIGINT
)
BEGIN
    DELETE FROM usuarios WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Usuario eliminado correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró el usuario con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;

