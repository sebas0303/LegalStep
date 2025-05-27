drop database if exists gestor_extranjeria;
create database gestor_extranjeria;
use gestor_extranjeria;

--  tabla: usuario
create table usuario (
    id_usuario int auto_increment primary key,
    nombre_usuario varchar(50) unique not null,
    correo varchar(100) not null,
    contraseña varchar(255) not null,
    rol enum('cliente', 'gestor', 'admin') not null,
    fecha_creacion datetime default current_timestamp,
    activo boolean default true
);

--  tabla: cliente
create table cliente (
    id_cliente int auto_increment primary key,
    id_usuario int unique,
    nombre varchar(100) not null,
    apellidos varchar(100) not null,
    nie_pasaporte varchar(20) unique,
    fecha_caducidad varchar(20),
    pais_origen varchar(50),
    fecha_nacimiento date,
    direccion varchar(255),
    telefono varchar(20),
    email varchar(100),
    fecha_entrada_pais varchar(20),
    foreign key (id_usuario) references usuario(id_usuario) on delete cascade
);

--  tabla: gestor
create table gestor (
    id_gestor int auto_increment primary key,
    id_usuario int unique,
    nombre_completo varchar(100),
    dni varchar(20) unique,
    telefono varchar(20),
    especialidad varchar(50),
    fecha_ingreso date,
    foreign key (id_usuario) references usuario(id_usuario) on delete cascade
);

--  tabla: tramite
create table tramite (
    id_tramite int auto_increment primary key,
    id_cliente int not null,
    id_gestor int,
    tipo_tramite varchar(100),
    estado enum('pendiente', 'en proceso', 'completado') default 'pendiente',
    fecha_inicio date,
    fecha_cita date,
    fecha_vencimiento date,
    fecha_resolucion date,
    observaciones varchar(100),
    foreign key (id_cliente) references cliente(id_cliente) on delete cascade,
    foreign key (id_gestor) references gestor(id_gestor) on delete set null
);

--  tabla: alerta
create table alerta (
    id_alerta int auto_increment primary key,
    id_tramite int not null,
    tipo_alerta varchar(100),
    descripcion varchar(100),
    fecha_alerta date,
    atendida boolean default false,
    foreign key (id_tramite) references tramite(id_tramite) on delete cascade
);

--  tabla: documento
create table documento (
    id_documento int auto_increment primary key,
    id_tramite int not null,
    nombre_doc varchar(100),
    estado enum('pendiente', 'recibido', 'validado') default 'pendiente',
    fecha_subida date,
    ruta_archivo varchar(255),
    foreign key (id_tramite) references tramite(id_tramite) on delete cascade
);

--  tabla: historial_cambios
create table historial_cambios (
    id_historial int auto_increment primary key,
    id_tramite int not null,
    fecha_hora datetime default current_timestamp,
    usuario_modifico int not null,
    descripcion varchar(100),
    estado_anterior varchar(50),
    estado_nuevo varchar(50),
    foreign key (id_tramite) references tramite(id_tramite) on delete cascade,
    foreign key (usuario_modifico) references usuario(id_usuario) on delete cascade
);


insert into usuario (nombre_usuario, correo, contraseña, rol, fecha_creacion, activo) values
('juanperez', 'juan@example.com', 'hash123', 'cliente', now(), true),
('maria123', 'maria@example.com', 'hash456', 'gestor', now(), true),
('carlosm', 'carlos@example.com', 'hash789', 'cliente', now(), true),
('admin1', 'admin@example.com', 'adminhash', 'admin', now(), true),
('lucia89', 'lucia@example.com', 'hashabc', 'cliente', now(), true),
('gestor1', 'gestor1@example.com', 'gestorhash', 'gestor', now(), true),
('gestor2', 'gestor2@example.com', 'hashg2', 'gestor', now(), true),
('clientex', 'clientex@example.com', 'clientehash', 'cliente', now(), true),
('ana23', 'ana23@example.com', 'hashana', 'cliente', now(), true),
('marco22', 'marco@example.com', 'hashmarco', 'cliente', now(), true);


insert into cliente (id_usuario, nombre, apellidos, nie_pasaporte, fecha_caducidad, pais_origen, fecha_nacimiento, direccion, telefono, email, fecha_entrada_pais) values
(1, 'juan', 'perez', 'x1234567', '2026-01-01', 'argentina', '1990-05-12', 'calle 1', '600123456', 'juan@example.com', '2021-03-10'),
(3, 'carlos', 'martinez', 'y7654321', '2025-08-20', 'colombia', '1988-11-30', 'calle 2', '611234567', 'carlos@example.com', '2020-10-15'),
(5, 'lucia', 'fernandez', 'z1122334', '2027-02-15', 'venezuela', '1995-07-19', 'calle 3', '622345678', 'lucia@example.com', '2022-05-01'),
(8, 'pablo', 'gomez', 'w4455667', '2026-09-30', 'peru', '1992-03-03', 'calle 4', '633456789', 'clientex@example.com', '2019-01-12'),
(9, 'ana', 'lopez', 'v9988776', '2024-12-10', 'ecuador', '1987-06-25', 'calle 5', '644567890', 'ana23@example.com', '2023-02-22'),
(10, 'marco', 'rios', 'u5544332', '2025-06-01', 'uruguay', '1991-04-11', 'calle 6', '655678901', 'marco@example.com', '2021-09-05');


insert into gestor (id_usuario, nombre_completo, dni, telefono, especialidad, fecha_ingreso) values
(2, 'maria gomez', '12345678a', '600000001', 'nacionalidad', '2020-01-01'),
(16, 'jorge lópez', '23456789b', '600000002', 'residencia', '2019-06-15'),
(17, 'rocio martinez', '34567890c', '600000003', 'reagrupación', '2021-03-20'),
(36, 'sofia pérez', '45678901d', '600000004', 'renovaciones', '2022-07-10'),
(27, 'nicolas ruiz', '56789012e', '600000005', 'visados', '2023-05-05');


insert into tramite (id_cliente, id_gestor, tipo_tramite, estado, fecha_inicio, fecha_cita, fecha_vencimiento, fecha_resolucion, observaciones) values
(1, 1, 'nacionalidad', 'pendiente', '2024-01-01', '2024-01-15', '2024-06-01', null, 'pendiente de cita'),
(2, 2, 'residencia inicial', 'en proceso', '2023-11-20', '2023-12-01', '2024-05-20', null, 'documentos en revisión'),
(3, 3, 'renovación nie', 'completado', '2023-08-01', '2023-08-15', '2024-08-01', '2023-09-01', 'aprobado sin observaciones'),
(4, 4, 'visado trabajo', 'pendiente', '2024-02-10', null, '2024-07-10', null, 'falta presentar contrato'),
(5, 5, 'reagrupación familiar', 'en proceso', '2023-10-05', '2023-10-20', '2024-03-05', null, 'esperando respuesta'),
(6, 6, 'nacionalidad', 'completado', '2022-07-07', '2022-07-21', '2023-01-07', '2022-12-15', 'concedida'),
(7, 7, 'renovación residencia', 'en proceso', '2024-01-20', null, '2024-06-20', null, 'faltan documentos'),
(8, 8, 'permiso de trabajo', 'pendiente', '2024-03-03', null, '2024-08-03', null, 'aún sin cita'),
(9, 9, 'nie primera vez', 'completado', '2023-04-14', '2023-04-28', '2023-10-14', '2023-05-20', 'todo correcto'),
(10, 10, 'autorización regreso', 'pendiente', '2024-05-01', null, '2024-06-01', null, 'solicitado con urgencia');


insert into alerta (id_tramite, tipo_alerta, descripcion, fecha_alerta, atendida) values
(1, 'cita pendiente', 'debe agendar cita', '2024-01-10', false),
(2, 'documento faltante', 'falta pasaporte escaneado', '2023-11-25', true),
(3, 'resolución disponible', 'tramite completado', '2023-09-01', true),
(4, 'faltan documentos', 'no se ha subido contrato', '2024-02-15', false),
(5, 'respuesta administración', 'revisión en curso', '2024-01-10', true),
(6, 'finalización', 'se resolvió favorablemente', '2022-12-20', true),
(7, 'incompleto', 'no se subieron todos los documentos', '2024-01-25', false),
(8, 'cita necesaria', 'sin cita asignada', '2024-03-05', false),
(9, 'resuelto', 'todo correcto', '2023-05-21', true),
(10, 'urgente', 'se requiere respuesta rápida', '2024-05-02', false);


insert into documento (id_tramite, nombre_doc, estado, fecha_subida, ruta_archivo) values
(1, 'dni escaneado', 'pendiente', '2024-01-05', '/docs/1/dni.pdf'),
(2, 'pasaporte', 'recibido', '2023-11-22', '/docs/2/pasaporte.pdf'),
(3, 'certificado nacimiento', 'validado', '2023-08-05', '/docs/3/nacimiento.pdf'),
(4, 'contrato trabajo', 'pendiente', null, null),
(5, 'empadronamiento', 'recibido', '2023-10-10', '/docs/5/empadronamiento.pdf'),
(6, 'certificado penales', 'validado', '2022-07-10', '/docs/6/penales.pdf'),
(7, 'renovación nie anterior', 'pendiente', null, null),
(8, 'oferta trabajo', 'pendiente', null, null),
(9, 'resguardo cita', 'validado', '2023-04-29', '/docs/9/cita.pdf'),
(10, 'billete regreso', 'recibido', '2024-05-01', '/docs/10/billete.pdf');


insert into historial_cambios (id_tramite, fecha_hora, usuario_modifico, descripcion, estado_anterior, estado_nuevo) values
(1, now(), 2, 'creación del trámite', null, 'pendiente'),
(2, now(), 6, 'documento recibido', 'pendiente', 'en proceso'),
(3, '2023-09-01 10:00:00', 7, 'resuelto favorable', 'en proceso', 'completado'),
(4, now(), 6, 'se solicitó contrato', 'pendiente', 'pendiente'),
(5, now(), 7, 'esperando revisión', 'pendiente', 'en proceso'),
(6, '2022-12-10 15:00:00', 2, 'documentos completos', 'en proceso', 'completado'),
(7, now(), 6, 'notificado falta de documentos', 'pendiente', 'en proceso'),
(8, now(), 7, 'sin cita asignada aún', 'pendiente', 'pendiente'),
(9, '2023-05-21 09:00:00', 6, 'finalización de trámite', 'en proceso', 'completado'),
(10, now(), 2, 'revisión inicial', 'pendiente', 'pendiente');
