
CREATE DATABASE IF NOT EXISTS gestor_extranjeria;
USE gestor_extranjeria;

-- Tabla de usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(100) NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    rol ENUM('cliente', 'gestor', 'administrador') NOT NULL
);

-- Tabla de clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    dni VARCHAR(50) UNIQUE NOT NULL,
    pais_origen VARCHAR(100),
    fecha_nacimiento DATE,
    direccion VARCHAR(255),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla de gestores
CREATE TABLE gestores (
    id_gestor INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    especialidad VARCHAR(100),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla de trámites
CREATE TABLE tramites (
    id_tramite INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_gestor INT,
    tipo_tramite VARCHAR(100),
    estado ENUM('pendiente', 'en proceso', 'completado', 'cancelado') NOT NULL,
    fecha_inicio DATE,
    fecha_fin DATE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_gestor) REFERENCES gestores(id_gestor)
);

-- Tabla de documentos
CREATE TABLE documentos (
    id_documento INT AUTO_INCREMENT PRIMARY KEY,
    id_tramite INT NOT NULL,
    nombre_documento VARCHAR(100),
    estado ENUM('pendiente', 'recibido', 'validado') NOT NULL,
    fecha_subida DATE,
    archivo_url VARCHAR(255),
    FOREIGN KEY (id_tramite) REFERENCES tramites(id_tramite)
);

-- Tabla de pagos
CREATE TABLE pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_tramite INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    metodo_pago ENUM('efectivo', 'transferencia', 'tarjeta'),
    estado_pago ENUM('pendiente', 'pagado', 'parcial'),
    fecha_pago DATE,
    FOREIGN KEY (id_tramite) REFERENCES tramites(id_tramite)
);

-- Tabla de citas
CREATE TABLE citas (
    id_cita INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_gestor INT,
    id_tramite INT,
    fecha_cita DATETIME NOT NULL,
    tipo_cita ENUM('presencial', 'virtual'),
    motivo TEXT,
    estado ENUM('pendiente', 'confirmada', 'cancelada', 'realizada'),
    observaciones TEXT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_gestor) REFERENCES gestores(id_gestor),
    FOREIGN KEY (id_tramite) REFERENCES tramites(id_tramite)
);

-- Tabla de alertas
CREATE TABLE alertas (
    id_alerta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_tramite INT,
    tipo_alerta VARCHAR(100),
    descripcion TEXT,
    fecha_alerta DATE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_tramite) REFERENCES tramites(id_tramite)
);

-- Tabla de historial de cambios
CREATE TABLE historial_cambio (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_tramite INT,
    fecha_hora DATETIME NOT NULL,
    descripcion TEXT,
    estado_anterior VARCHAR(100),
    estado_nuevo VARCHAR(100),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_tramite) REFERENCES tramites(id_tramite)
);
