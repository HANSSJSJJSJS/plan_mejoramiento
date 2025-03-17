CREATE DATABASE medical_cardenas;
USE medical_cardenas;

-- Tabla usuarios
CREATE TABLE usuarios (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    password VARCHAR(128),
    last_login DATETIME,
    is_superuser TINYINT,
    username VARCHAR(150),
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    email VARCHAR(254),
    is_staff TINYINT,
    is_active TINYINT,
    date_joined DATETIME,
    tipo_doc ENUM('CC', 'CE'),
    num_doc VARCHAR(20),
    fecha_nac DATE,
    ciudad_nac VARCHAR(100),
    direccion VARCHAR(100),
    telefono VARCHAR(100),
    imagen VARCHAR(100)
);

-- Tabla medicos
CREATE TABLE medicos (
    id BIGINT AUTO_INCREMENT,
    carnet VARCHAR(45),
    especialidad VARCHAR(45),
    usuarios_id BIGINT NOT NULL,
    PRIMARY KEY (id, usuarios_id), 
    FOREIGN KEY (usuarios_id) REFERENCES usuarios(id) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Tabla pacientes
CREATE TABLE pacientes (
    id BIGINT AUTO_INCREMENT,
    genero ENUM('M', 'F'),
    usuarios_id BIGINT NOT NULL,
    PRIMARY KEY (id, usuarios_id), 
    FOREIGN KEY (usuarios_id) REFERENCES usuarios(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla consultas_medicas
CREATE TABLE consultas_medicas (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE,
    pacientes_id BIGINT NOT NULL,
    medicos_id BIGINT NOT NULL,
    FOREIGN KEY (pacientes_id) REFERENCES pacientes(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (medicos_id) REFERENCES medicos(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla historiales_clinicos
CREATE TABLE historiales_clinicos (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    fecha_consulta DATE,
    motivo_consulta TEXT,
    diagnostico TEXT,
    tratamiento TEXT,
    pacientes_id BIGINT NOT NULL,
    medicos_id BIGINT NOT NULL,
    FOREIGN KEY (pacientes_id) REFERENCES pacientes(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (medicos_id) REFERENCES medicos(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla anamnesis
CREATE TABLE anamnesis (
    id BIGINT AUTO_INCREMENT,
    motivo_consulta TEXT,
    enfer_actual TEXT,
    antec_pers TEXT,
    antec_fam TEXT,
    habitos TEXT,
    consultas_medicas_id BIGINT NOT NULL,
    PRIMARY KEY (id,consultas_medicas_id ), 
    FOREIGN KEY (consultas_medicas_id) REFERENCES consultas_medicas(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla diagnostico
CREATE TABLE diagnostico (
    id BIGINT AUTO_INCREMENT,
    descripcion TEXT,
    codigo_cie VARCHAR(20),
    consultas_medicas_id BIGINT NOT NULL,
    PRIMARY KEY (id,consultas_medicas_id ), 
    FOREIGN KEY (consultas_medicas_id) REFERENCES consultas_medicas(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla tratamientos
CREATE TABLE tratamientos (
    id INT AUTO_INCREMENT,
    medicamentos TEXT,
    recomendaciones TEXT,
    consultas_medicas_id BIGINT NOT NULL,
    PRIMARY KEY (id,consultas_medicas_id ), 
    FOREIGN KEY (consultas_medicas_id) REFERENCES consultas_medicas(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla exploraciones_fisicas
CREATE TABLE exploraciones_fisicas (
    id BIGINT AUTO_INCREMENT,
    pre_arterial VARCHAR(50),
    frec_cardiaca INT,
    temp DECIMAL(4,2),
    peso DECIMAL(5,2),
    hallazgos TEXT,
    consultas_medicas_id BIGINT NOT NULL,
	PRIMARY KEY (id,consultas_medicas_id ), 
    FOREIGN KEY (consultas_medicas_id) REFERENCES consultas_medicas(id) ON DELETE CASCADE ON UPDATE CASCADE
);


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

-- ------------------------------------------------------------procesos de almacenamiento PACIENTES
DELIMITER //
CREATE PROCEDURE InsertarPaciente(
    IN p_genero ENUM('M', 'F'),
    IN p_usuarios_id BIGINT
)
BEGIN
    INSERT INTO pacientes (genero, usuarios_id)
    VALUES (p_genero, p_usuarios_id);
    SELECT 'Paciente insertado correctamente' AS Mensaje;
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


-- --------------------------------------------------procesos de almacenamiento CONSULTAS MEDICAS

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


-- ------------------------------------------------------------procesos de almacenamiento HISTORIALES CLINICOS 
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


-- -------------------------------------------------------------------------------procesos de almacenamiento ANAMNESIS

DELIMITER //
CREATE PROCEDURE InsertarAnamnesis(
    IN p_motivo_consulta TEXT,
    IN p_enfer_actual TEXT,
    IN p_antec_pers TEXT,
    IN p_antec_fam TEXT,
    IN p_habitos TEXT,
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    INSERT INTO anamnesis (
        motivo_consulta, enfer_actual, antec_pers, antec_fam, habitos, consultas_medicas_id
    ) VALUES (
        p_motivo_consulta, p_enfer_actual, p_antec_pers, p_antec_fam, p_habitos, p_consultas_medicas_id
    );
    SELECT 'Anamnesis insertada correctamente' AS Mensaje;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerAnamnesisPorID(
    IN p_id BIGINT
)
BEGIN
    SELECT * FROM anamnesis WHERE id = p_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerAnamnesisPorConsultaMedica(
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    SELECT * FROM anamnesis WHERE consultas_medicas_id = p_consultas_medicas_id;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE MostrarTodasAnamnesis()
BEGIN
    SELECT * FROM anamnesis;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE ActualizarAnamnesis(
    IN p_id BIGINT,
    IN p_motivo_consulta TEXT,
    IN p_enfer_actual TEXT,
    IN p_antec_pers TEXT,
    IN p_antec_fam TEXT,
    IN p_habitos TEXT,
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    UPDATE anamnesis
    SET
        motivo_consulta = p_motivo_consulta,
        enfer_actual = p_enfer_actual,
        antec_pers = p_antec_pers,
        antec_fam = p_antec_fam,
        habitos = p_habitos,
        consultas_medicas_id = p_consultas_medicas_id
    WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Anamnesis actualizada correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró la anamnesis con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE EliminarAnamnesis(
    IN p_id BIGINT
)
BEGIN
    DELETE FROM anamnesis WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Anamnesis eliminada correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró la anamnesis con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;

-- -----------------------------------------------------------procesos de almacenamiento DIAGNOSTICO 
DELIMITER //
CREATE PROCEDURE InsertarDiagnostico(
    IN p_descripcion TEXT,
    IN p_codigo_cie VARCHAR(20),
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    INSERT INTO diagnostico (
        descripcion, codigo_cie, consultas_medicas_id
    ) VALUES (
        p_descripcion, p_codigo_cie, p_consultas_medicas_id
    );
    SELECT 'Diagnóstico insertado correctamente' AS Mensaje;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerDiagnosticoPorID(
    IN p_id BIGINT
)
BEGIN
    SELECT * FROM diagnostico WHERE id = p_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerDiagnosticosPorConsultaMedica(
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    SELECT * FROM diagnostico WHERE consultas_medicas_id = p_consultas_medicas_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE MostrarTodosDiagnosticos()
BEGIN
    SELECT * FROM diagnostico;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarDiagnostico(
    IN p_id BIGINT,
    IN p_descripcion TEXT,
    IN p_codigo_cie VARCHAR(20),
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    UPDATE diagnostico
    SET
        descripcion = p_descripcion,
        codigo_cie = p_codigo_cie,
        consultas_medicas_id = p_consultas_medicas_id
    WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Diagnóstico actualizado correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró el diagnóstico con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE EliminarDiagnostico(
    IN p_id BIGINT
)
BEGIN
    DELETE FROM diagnostico WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Diagnóstico eliminado correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró el diagnóstico con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;


-- ------------------------------------------------procesos de almacenamiento TRATAMIENTOS
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

-- -----------------------------------------------------------------procesos de almacenamiento EXPLORACIONES FISICAS 

DELIMITER //
CREATE PROCEDURE InsertarExploracionFisica(
    IN p_pre_arterial VARCHAR(50),
    IN p_frec_cardiaca INT,
    IN p_temp DECIMAL(4,2),
    IN p_peso DECIMAL(5,2),
    IN p_hallazgos TEXT,
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    INSERT INTO exploraciones_fisicas (
        pre_arterial, frec_cardiaca, temp, peso, hallazgos, consultas_medicas_id
    ) VALUES (
        p_pre_arterial, p_frec_cardiaca, p_temp, p_peso, p_hallazgos, p_consultas_medicas_id
    );
    SELECT 'Exploración física insertada correctamente' AS Mensaje;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerExploracionFisicaPorID(
    IN p_id BIGINT
)
BEGIN
    SELECT * FROM exploraciones_fisicas WHERE id = p_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerExploracionesPorConsultaMedica(
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    SELECT * FROM exploraciones_fisicas WHERE consultas_medicas_id = p_consultas_medicas_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE MostrarTodasExploracionesFisicas()
BEGIN
    SELECT * FROM exploraciones_fisicas;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE ActualizarExploracionFisica(
    IN p_id BIGINT,
    IN p_pre_arterial VARCHAR(50),
    IN p_frec_cardiaca INT,
    IN p_temp DECIMAL(4,2),
    IN p_peso DECIMAL(5,2),
    IN p_hallazgos TEXT,
    IN p_consultas_medicas_id BIGINT
)
BEGIN
    UPDATE exploraciones_fisicas
    SET
        pre_arterial = p_pre_arterial,
        frec_cardiaca = p_frec_cardiaca,
        temp = p_temp,
        peso = p_peso,
        hallazgos = p_hallazgos,
        consultas_medicas_id = p_consultas_medicas_id
    WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Exploración física actualizada correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró la exploración física con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE EliminarExploracionFisica(
    IN p_id BIGINT
)
BEGIN
    DELETE FROM exploraciones_fisicas WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT 'Exploración física eliminada correctamente' AS Mensaje;
    ELSE
        SELECT 'No se encontró la exploración física con el ID proporcionado' AS Mensaje;
    END IF;
END //
DELIMITER ;