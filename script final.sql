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


INSERT INTO usuario (nombre_usuario, correo, contraseña, rol, fecha_creacion, activo) VALUES

('juan_perez', 'juan@example.com', 'clave123', 'cliente', '2025-05-01 10:00:00', true),
('maria_lopez', 'maria@example.com', 'clave456', 'cliente', '2025-05-02 11:15:00', true),
('ana_gomez', 'ana@example.com', 'clave789', 'cliente', '2025-05-03 09:30:00', true),
('carlos_ramos', 'carlos@example.com', 'clave321', 'cliente', '2025-05-04 14:20:00', true),
('sofia_martinez', 'sofia@example.com', 'clave654', 'cliente', '2025-05-05 08:45:00', true),
('luis_torres', 'luis@example.com', 'clave987', 'cliente', '2025-05-06 13:10:00', true),
('jose_arias', 'jose@example.com', 'clave159', 'cliente', '2025-05-07 16:05:00', true),
('elena_mendez', 'elena@example.com', 'clave753', 'cliente', '2025-05-08 12:00:00', true),
('diego_soto', 'diego@example.com', 'clave852', 'cliente', '2025-05-09 15:30:00', true),
('laura_valdez', 'laura@example.com', 'clave963', 'cliente', '2025-05-10 17:25:00', true),
('gestor1', 'gestor1@example.com', 'clavegestor1', 'gestor', '2025-05-01 08:00:00', true),
('gestor2', 'gestor2@example.com', 'clavegestor2', 'gestor', '2025-05-02 08:00:00', true),
('gestor3', 'gestor3@example.com', 'clavegestor3', 'gestor', '2025-05-03 08:00:00', true),
('gestor4', 'gestor4@example.com', 'clavegestor4', 'gestor', '2025-05-04 08:00:00', true),
('gestor5', 'gestor5@example.com', 'clavegestor5', 'gestor', '2025-05-05 08:00:00', true),
('gestor6', 'gestor6@example.com', 'clavegestor6', 'gestor', '2025-05-06 08:00:00', true),
('gestor7', 'gestor7@example.com', 'clavegestor7', 'gestor', '2025-05-07 08:00:00', true),
('gestor8', 'gestor8@example.com', 'clavegestor8', 'gestor', '2025-05-08 08:00:00', true),
('gestor9', 'gestor9@example.com', 'clavegestor9', 'gestor', '2025-05-09 08:00:00', true),
('gestor10', 'gestor10@example.com', 'clavegestor10', 'gestor', '2025-05-10 08:00:00', true),
('admin', 'admin@example.com', 'claveadmin', 'admin', '2025-05-01 07:00:00', true);



INSERT INTO cliente (
    id_usuario, nombre, apellidos, nie_pasaporte, fecha_caducidad, pais_origen,
    fecha_nacimiento, direccion, telefono, email, fecha_entrada_pais) VALUES
(1, 'Carlos', 'Ramírez Soto', 'X1234567A', '2027-03-15', 'Perú', '1995-06-12',
'Calle Mayor 12, Madrid', '611223344', 'carlos.ramirez@example.com', '2020-09-01'),
(2, 'María', 'López Fernández', 'Y8765432B', '2026-12-20', 'Colombia', '1998-04-22',
 'Av. Andalucía 45, Sevilla', '622334455', 'maria.lopez@example.com', '2021-03-15'),
(3, 'Luis', 'Torres Gutiérrez', 'Z3344556C', '2025-11-05', 'Argentina', '1989-11-08',
 'C/Granada 10, Málaga', '633445566', 'luis.torres@example.com', '2019-07-10'),
(4, 'Ana', 'Martínez Gómez', 'X8899007D', '2028-06-01', 'Ecuador', '1993-02-19',
 'C/Toledo 67, Toledo', '644556677', 'ana.martinez@example.com', '2022-01-25'),
(5, 'Jorge', 'Pérez Núñez', 'Y2233445E', '2027-08-30', 'Venezuela', '1990-09-14',
 'C/Salamanca 33, Salamanca', '655667788', 'jorge.perez@example.com', '2020-05-05'),
(6, 'Valeria', 'Moreno Díaz', 'Z5566778F', '2026-10-10', 'México', '1996-07-03',
 'C/Lugo 88, Lugo', '666778899', 'valeria.moreno@example.com', '2021-11-12'),
(7, 'Diego', 'Sánchez Ruiz', 'X1122334G', '2025-09-12', 'Bolivia', '1991-03-28',
 'Av. Coruña 25, A Coruña', '677889900', 'diego.sanchez@example.com', '2020-04-18'),
(8, 'Lucía', 'Navarro León', 'Y9988776H', '2029-01-01', 'Chile', '1994-12-30',
 'C/Vigo 14, Vigo', '688990011', 'lucia.navarro@example.com', '2023-02-28'),
(9, 'Eduardo', 'Castillo Ramos', 'Z6677889I', '2027-07-07', 'Uruguay', '1992-01-17',
 'C/Burgos 90, Burgos', '699001122', 'eduardo.castillo@example.com', '2021-08-20'),
(10, 'Camila', 'García Paredes', 'X4455667J', '2026-04-15', 'Paraguay', '1997-10-05',
 'C/Cáceres 55, Cáceres', '610112233', 'camila.garcia@example.com', '2022-05-09');



INSERT INTO gestor (id_usuario, nombre_completo, dni, telefono, especialidad, fecha_ingreso) VALUES
(11, 'Javier Ortega García', '12345678A', '611112223', 'Extranjería', '2021-03-15'),
(12, 'Sofía Delgado Ruiz', '23456789B', '622223334', 'Nacionalidad', '2022-06-20'),
(13, 'Miguel Alonso Pérez', '34567890C', '633334445', 'Homologación', '2020-11-10'),
(14, 'Paula Fernández Torres', '45678901D', '644445556', 'Residencias', '2023-01-05'),
(15, 'Andrés Morales López', '56789012E', '655556667', 'Estudios', '2022-03-12'),
(16, 'Laura Sánchez Molina', '67890123F', '666667778', 'Renovaciones', '2021-07-30'),
(17, 'Ricardo Herrera Díaz', '78901234G', '677778889', 'Arraigo', '2020-09-18'),
(18, 'Carmen Vidal Cano', '89012345H', '688889900', 'Permisos laborales', '2022-05-25'),
(19, 'Daniel Ríos Martín', '90123456I', '699990011', 'Informes sociales', '2023-02-14'),
(20, 'Elena Núñez Romero', '01234567J', '610001122', 'Reagrupación familiar', '2021-10-22');



INSERT INTO tramite (id_cliente, id_gestor, tipo_tramite, estado, fecha_inicio, fecha_cita, fecha_vencimiento, fecha_resolucion, observaciones) VALUES
(1, 1, 'Solicitud de residencia por estudios', 'en proceso', '2024-03-01', '2024-03-15', '2024-09-01', NULL, 'Documentación incompleta'),
(2, 2, 'Renovación de NIE', 'completado', '2023-10-05', '2023-10-20', '2024-10-05', '2024-01-12', 'Trámite exitoso'),
(3, 3, 'Solicitud de nacionalidad', 'pendiente', '2024-04-10', NULL, '2026-04-10', NULL, 'Esperando antecedentes penales'),
(4, NULL, 'Reagrupación familiar', 'pendiente', '2024-05-02', NULL, '2024-11-02', NULL, 'Falta asignar gestor'),
(5, 4, 'Cambio de domicilio en NIE', 'en proceso', '2024-02-14', '2024-02-28', '2024-08-14', NULL, 'Esperando resolución'),
(6, 5, 'Arraigo laboral', 'completado', '2023-07-01', '2023-07-20', '2024-07-01', '2023-12-10', 'Resuelto favorable'),
(7, 6, 'Renovación tarjeta comunitaria', 'pendiente', '2024-06-01', '2024-06-15', '2025-06-01', NULL, 'Agendado cita'),
(8, 7, 'Permiso de trabajo inicial', 'en proceso', '2024-01-12', '2024-01-30', '2024-07-12', NULL, 'Esperando respuesta SEPE'),
(9, NULL, 'Modificación a residencia por trabajo', 'pendiente', '2024-03-25', NULL, '2024-09-25', NULL, 'Gestor por asignar'),
(10, 8, 'Solicitud de protección internacional', 'completado', '2023-05-18', '2023-06-01', '2024-05-18', '2024-04-10', 'Resolución positiva');



INSERT INTO alerta (id_tramite, tipo_alerta, descripcion, fecha_alerta, atendida) VALUES
(1, 'Documentación incompleta', 'Falta entregar certificado de estudios', '2024-03-10', false),
(2, 'Cita próxima', 'Recordatorio cita para renovación NIE', '2023-10-15', true),
(3, 'Retraso en trámite', 'Pendiente resolución de antecedentes', '2024-05-01', false),
(4, 'Asignar gestor', 'Cliente sin gestor asignado', '2024-05-05', false),
(5, 'Pago pendiente', 'Falta abonar tasa administrativa', '2024-02-20', true),
(6, 'Documentación aceptada', 'Se ha recibido toda la documentación', '2023-07-10', true),
(7, 'Cita próxima', 'Recordatorio cita para renovación tarjeta', '2024-06-10', false),
(8, 'Seguimiento', 'Esperando respuesta de SEPE', '2024-01-25', false),
(9, 'Gestor asignado', 'Gestor asignado al trámite', '2024-04-01', true),
(10, 'Trámite finalizado', 'Protección internacional concedida', '2024-04-15', true);



INSERT INTO documento (id_tramite, nombre_doc, estado, fecha_subida, ruta_archivo) VALUES
(1, 'Pasaporte Escaneado', 'validado', '2024-02-20', '/docs/tramite1/pasaporte.pdf'),
(2, 'Formulario de Solicitud', 'recibido', '2024-03-05', '/docs/tramite2/form_solicitud.pdf'),
(3, 'Certificado de Nacimiento', 'pendiente', NULL, '/docs/tramite3/cert_nacimiento.pdf'),
(4, 'Contrato de Trabajo', 'validado', '2024-01-15', '/docs/tramite4/contrato_trabajo.pdf'),
(5, 'Justificante de Pago', 'recibido', '2024-04-10', '/docs/tramite5/just_pago.pdf'),
(6, 'Foto Carnet', 'validado', '2023-12-30', '/docs/tramite6/foto_carnet.jpg'),
(7, 'Documentación Residencia', 'pendiente', NULL, '/docs/tramite7/doc_residencia.pdf'),
(8, 'Informe Médico', 'recibido', '2024-02-28', '/docs/tramite8/informe_medico.pdf'),
(9, 'Carta de Invitación', 'validado', '2024-03-22', '/docs/tramite9/carta_invitacion.pdf'),
(10, 'Resolución Administrativa', 'validado', '2024-04-16', '/docs/tramite10/resolucion.pdf');



INSERT INTO historial_cambios (id_tramite, fecha_hora, usuario_modifico, descripcion, estado_anterior, estado_nuevo) VALUES
(1, '2024-02-15 10:30:00', 8, 'Cambio de estado de pendiente a en proceso', 'pendiente', 'en proceso'),
(2, '2024-03-01 15:45:00', 3, 'Asignación de gestor y cambio a en proceso', 'pendiente', 'en proceso'),
(3, '2024-04-05 09:20:00', 10, 'Cambio a completado tras revisión', 'en proceso', 'completado'),
(4, '2024-01-20 14:00:00', 5, 'Estado actualizado a pendiente tras revisión', 'en proceso', 'pendiente'),
(5, '2024-03-25 11:10:00', 2, 'Trámite marcado como completado', 'en proceso', 'completado'),
(6, '2023-12-28 16:50:00', 7, 'Documento recibido, trámite en proceso', 'pendiente', 'en proceso'),
(7, '2024-04-10 13:30:00', 1, 'Estado cambiado a completado', 'en proceso', 'completado'),
(8, '2024-02-28 08:15:00', 4, 'Cambio de pendiente a en proceso', 'pendiente', 'en proceso'),
(9, '2024-03-22 17:45:00', 6, 'Cambio estado trámite a completado', 'en proceso', 'completado'),
(10, '2024-04-16 12:00:00', 9, 'Actualización de estado tras reunión', 'pendiente', 'en proceso');

