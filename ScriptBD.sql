
CREATE DATABASE gestor_extranjeria;
USE gestor_extranjeria;

CREATE TABLE permiso (
    id VARCHAR(36) PRIMARY KEY,
    rol VARCHAR(50) NOT NULL,
    descripcion TEXT
);

CREATE TABLE usuario (
    id VARCHAR(36) PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    rol VARCHAR(50) NOT NULL,
    permiso_id VARCHAR(36),
    FOREIGN KEY (permiso_id) REFERENCES permiso(id)
);

CREATE TABLE cliente (
    id VARCHAR(36) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    nacionalidad VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE expediente (
    id VARCHAR(36) PRIMARY KEY,
    cliente_id VARCHAR(36) NOT NULL,
    tramite_id VARCHAR(36),
    fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id)
    -- tramite_id será referenciado más abajo por la tabla tramite
);

CREATE TABLE usuario_expediente (
    usuario_id VARCHAR(36) NOT NULL,
    expediente_id VARCHAR(36) NOT NULL,
    PRIMARY KEY (usuario_id, expediente_id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (expediente_id) REFERENCES expediente(id)
);

CREATE TABLE tramite (
    id VARCHAR(36) PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    estado VARCHAR(50) NOT NULL,
    expediente_id VARCHAR(36) NOT NULL,
    FOREIGN KEY (expediente_id) REFERENCES expediente(id)
);

CREATE TABLE documento (
    id VARCHAR(36) PRIMARY KEY,
    expediente_id VARCHAR(36) NOT NULL,
    nombre_archivo VARCHAR(255) NOT NULL,
    fecha_subida DATE NOT NULL,
    tipo_documento VARCHAR(50),
    FOREIGN KEY (expediente_id) REFERENCES expediente(id)
);

CREATE TABLE historial_cambio (
    id VARCHAR(36) PRIMARY KEY,
    expediente_id VARCHAR(36) NOT NULL,
    fecha_cambio DATETIME NOT NULL,
    detalle_cambio TEXT NOT NULL,
    FOREIGN KEY (expediente_id) REFERENCES expediente(id)
);

CREATE TABLE alerta (
    id VARCHAR(36) PRIMARY KEY,
    mensaje VARCHAR(255) NOT NULL,
    fecha_vencimiento DATE,
    es_activo BOOLEAN DEFAULT TRUE,
    tramite_id VARCHAR(36) NOT NULL,
    FOREIGN KEY (tramite_id) REFERENCES tramite(id)
);

