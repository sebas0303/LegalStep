# Entrevista con el Cliente y Requisitos del Proyecto

## El Negocio

**Gestoría y Asesoría en trámites de extranjería e inmigración "LegalStep"**

### Contexto del Negocio

Como dueño de *LegalStep*, dirijo una gestoría especializada en servicios de extranjería e inmigración. Mi negocio se centra en ayudar a personas extranjeras a navegar por los complejos procesos legales y administrativos necesarios para establecerse en el país.

Ofrecemos asesoramiento personalizado en trámites como:

- Permisos de residencia
- Visados
- Nacionalidad
- Reagrupación familiar
- Renovaciones de documentos

Contamos con un equipo de profesionales especializados en derecho migratorio y mantenemos relaciones sólidas con las administraciones públicas relevantes.

**Nuestro modelo operativo se basa en:**

- Atención personalizada y seguimiento individual de cada caso
- Gestión integral de documentación
- Actualización constante sobre cambios en normativas migratorias
- Acompañamiento en trámites presenciales cuando sea necesario

---

## Conversación con el Cliente

**Asistente**: ¡Hola! Soy el dueño del negocio y estoy buscando desarrollar un sistema de base de datos que me ayude a gestionar mejor mi empresa. ¿Qué te gustaría saber sobre nuestras necesidades y operaciones?

**Human:**

- ¿Qué datos básicos debería registrar de cada cliente?
- ¿Cómo debería organizar la información de los diferentes trámites que tiene un mismo cliente?
- ¿Qué tipo de alertas o recordatorios crees que serían útiles para no olvidar plazos importantes?
- ¿Sería útil tener historial de cambios en los trámites?
- ¿Cómo podría organizar los documentos requeridos para cada tipo de trámite?

---

## Requisitos Identificados

### 📌 Datos básicos del cliente

- Nombre completo y apellidos
- NIE/Pasaporte
- País de origen
- Fecha de nacimiento
- Dirección actual
- Teléfono(s) de contacto
- Email
- Idioma preferido
- Situación laboral actual
- Fecha de entrada al país
- Documentos de identidad vigentes y sus fechas de caducidad

### 📌 Organización de trámites por cliente

- Crear expedientes individuales por cada trámite
- Vincular todos los expedientes a la ficha del cliente
- Registrar estado actual (en proceso, pendiente, completado, etc.)
- Fechas clave de cada trámite
- Responsable asignado del equipo

### 📌 Alertas y recordatorios importantes

- Vencimiento de documentos/permisos
- Plazos límite para presentar solicitudes
- Fechas de citas programadas
- Documentos pendientes de entregar
- Pagos pendientes
- Seguimiento de resoluciones

### 📌 Historial de cambios

Sí, registrar:

- Fecha y hora de cada modificación
- Usuario que realizó el cambio
- Descripción del cambio realizado
- Estado anterior y nuevo estado
- Documentos añadidos/modificados

### 📌 Organización de documentos por trámite

- Crear una lista maestra de documentos requeridos por tipo de trámite
- Checklist personalizable según el caso
- Estado de cada documento (pendiente/recibido/validado)
- Sistema de almacenamiento digital organizado por:
  - Tipo de trámite
  - Cliente
  - Fecha
  - Categoría de documentos

---

## Entidades y Atributos

### 🧩 Entidad: Usuario

| Atributo         | Tipo                                 | Descripción                      |
|------------------|--------------------------------------|----------------------------------|
| id_usuario (PK)  | INT                                  | Identificador único              |
| nombre_usuario   | VARCHAR                              | Nombre de acceso al sistema      |
| correo           | VARCHAR                              | Correo electrónico asociado      |
| contraseña_hash  | VARCHAR                              | Contraseña cifrada               |
| rol              | ENUM('cliente', 'gestor', 'admin')   | Tipo de usuario                  |
| fecha_creacion   | DATETIME                             | Fecha de registro                |
| activo           | BOOLEAN                              | Cuenta activa o deshabilitada    |

---

### 🧩 Entidad: Cliente

| Atributo             | Tipo        |
|----------------------|-------------|
| id_cliente (PK)      | INT         |
| nombre               | VARCHAR     |
| apellidos            | VARCHAR     |
| NIE_pasaporte        | VARCHAR     |
| pais_origen          | VARCHAR     |
| fecha_nacimiento     | DATE        |
| direccion            | VARCHAR     |
| telefono1            | VARCHAR     |
| telefono2 (opcional) | VARCHAR     |
| email                | VARCHAR     |
| idioma_preferido     | VARCHAR     |
| situacion_laboral    | VARCHAR     |
| fecha_entrada_pais   | DATE        |

---

### 🧩 Entidad: Gestor

| Atributo         | Tipo        |
|------------------|-------------|
| id_gestor (PK)   | INT         |
| id_usuario (FK)  | INT         |
| nombre_completo  | VARCHAR(100)|
| dni              | VARCHAR(20) |
| telefono         | VARCHAR(20) |
| especialidad     | VARCHAR(50) |
| fecha_ingreso    | DATE        |

---

### 🧩 Entidad: Trámite

| Atributo          | Tipo                                 |
|-------------------|--------------------------------------|
| id_tramite (PK)   | INT                                  |
| id_cliente (FK)   | INT                                  |
| id_gestor (FK)    | INT                                  |
| tipo_tramite      | VARCHAR(100)                         |
| estado            | ENUM('pendiente', 'en proceso', 'completado') |
| fecha_inicio      | DATE                                 |
| fecha_cita        | DATE                                 |
| fecha_vencimiento | DATE                                 |
| fecha_resolucion  | DATE                                 |
| observaciones     | TEXT                                 |

---

### 🧩 Entidad: Alerta

| Atributo         | Tipo        |
|------------------|-------------|
| id_alerta (PK)   | INT         |
| id_tramite (FK)  | INT         |
| tipo_alerta      | VARCHAR(100)|
| descripcion      | TEXT        |
| fecha_alerta     | DATE        |
| atendida         | BOOLEAN     |

---

### 🧩 Entidad: Documento

| Atributo         | Tipo         |
|------------------|--------------|
| id_documento (PK)| INT          |
| id_tramite (FK)  | INT          |
| nombre_doc       | VARCHAR(100) |
| estado           | ENUM('pendiente', 'recibido', 'validado') |
| fecha_subida     | DATE         |
| ruta_archivo     | VARCHAR(255) |

---

### 🧩 Entidad: Historial_Cambios

| Atributo              | Tipo        |
|------------------------|-------------|
| id_historial (PK)      | INT         |
| id_tramite (FK)        | INT         |
| fecha_hora             | DATETIME    |
| usuario_modifico (FK)  | INT         |
| descripcion            | TEXT        |
| estado_anterior        | VARCHAR(50) |
| estado_nuevo           | VARCHAR(50) |
