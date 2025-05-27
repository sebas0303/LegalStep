drop database if exists gestor_extranjeria;

-- Crear base de datos
CREATE DATABASE gestor_extranjeria;
USE gestor_extranjeria;

-- Tabla: Permiso
CREATE TABLE permiso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rol VARCHAR(50) NOT NULL,
    descripcion varchar(100)
);

-- Tabla: Usuario
CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    rol VARCHAR(50) NOT NULL,
    permiso_id INT,
    FOREIGN KEY (permiso_id) REFERENCES permiso(id)
);

-- Tabla: Cliente
CREATE TABLE cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    nacionalidad VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE,
	telefono VARCHAR(20),
    email VARCHAR(100) NOT NULL UNIQUE,
	usuario_id INT NOT NULL UNIQUE,
	FOREIGN KEY (usuario_id) REFERENCES usuario(id)

);

-- Tabla: Gestor
CREATE TABLE gestor (
    id INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    usuario_id INT NOT NULL UNIQUE,
    especialidad VARCHAR(100),
    email VARCHAR(20) not null unique,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

-- Tabla: Admin
CREATE TABLE admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL UNIQUE,
    cargo VARCHAR(50),
    nivel_acceso INT DEFAULT 1,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);


-- Tabla: Expediente
CREATE TABLE expediente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

-- Tabla intermedia: usuario_expediente (usuario accede a expediente)
CREATE TABLE usuario_expediente (
    usuario_id INT NOT NULL,
    expediente_id INT NOT NULL,
    PRIMARY KEY (usuario_id, expediente_id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (expediente_id) REFERENCES expediente(id)
);

-- Tabla: Trámite
CREATE TABLE tramite (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    estado VARCHAR(50) NOT NULL,
    expediente_id INT NOT NULL,
    FOREIGN KEY (expediente_id) REFERENCES expediente(id)
);

-- Tabla: Documento
CREATE TABLE documento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    expediente_id INT NOT NULL,
    nombre_archivo VARCHAR(255) NOT NULL,
    fecha_subida DATE NOT NULL,
    tipo_documento VARCHAR(50),
    FOREIGN KEY (expediente_id) REFERENCES expediente(id)
);

-- Tabla: HistorialCambio
CREATE TABLE historial_cambio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    expediente_id INT NOT NULL,
    fecha_cambio DATETIME NOT NULL,
    detalle_cambio TEXT NOT NULL,
    FOREIGN KEY (expediente_id) REFERENCES expediente(id)
);

-- Tabla: Alerta
CREATE TABLE alerta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mensaje VARCHAR(255) NOT NULL,
    fecha_vencimiento DATE,
    es_activo BOOLEAN DEFAULT TRUE,
    tramite_id INT NOT NULL,
    FOREIGN KEY (tramite_id) REFERENCES tramite(id)
);


INSERT INTO permiso (rol, descripcion) VALUES 
('cliente', 'Acceso a sus propios expedientes y trámites'),
('gestor', 'Gestión de expedientes y trámites asignados'),
('admin', 'Control total del sistema');


INSERT INTO usuario (nombre_usuario, contraseña, rol, permiso_id) VALUES
('maria_fernandez', 'pass123', 'cliente', 1),
('juan_garcia', 'pass456', 'gestor', 2),
('admin_root', 'adminpass', 'admin', 3);


INSERT INTO cliente (nombre, apellido, nacionalidad, fecha_nacimiento, email) VALUES
('María', 'Fernández', 'Colombia', '1990-05-12', 'maria@example.com'),
('Ali', 'Hussein', 'Marruecos', '1985-11-20', 'ali@example.com');


INSERT INTO expediente (cliente_id) VALUES
(1), -- para María
(2); -- para Ali


-- María accede a su expediente (cliente)
INSERT INTO usuario_expediente (usuario_id, expediente_id) VALUES
(1, 1);

-- Gestor Juan accede a ambos expedientes
INSERT INTO usuario_expediente (usuario_id, expediente_id) VALUES
(2, 1),
(2, 2);


INSERT INTO tramite (tipo, descripcion, fecha_inicio, fecha_fin, estado, expediente_id) VALUES
('Renovación NIE', 'Trámite para renovar el NIE vencido', '2024-01-10', '2024-02-15', 'finalizado', 1),
('Reagrupación Familiar', 'Solicitud de reagrupación para esposa e hijos', '2025-03-01', NULL, 'en_proceso', 2);


INSERT INTO documento (expediente_id, nombre_archivo, fecha_subida, tipo_documento) VALUES
(1, 'nie_renovacion.pdf', '2024-01-11', 'Formulario EX-17'),
(2, 'reagrupacion_solicitud.pdf', '2025-03-05', 'Formulario EX-02');


INSERT INTO historial_cambio (expediente_id, fecha_cambio, detalle_cambio) VALUES
(1, '2024-02-10 10:30:00', 'Cambio de estado: en_proceso → finalizado'),
(2, '2025-03-10 15:45:00', 'Añadido documento adicional para estudio económico');


INSERT INTO alerta (mensaje, fecha_vencimiento, es_activo, tramite_id) VALUES
('Adjuntar nueva foto carnet', '2025-03-15', TRUE, 2),
('Revisar documento rechazado', '2024-01-20', FALSE, 1);
