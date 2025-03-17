
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
