# 📊 Proyecto Diseño de Base de Datos para Cliente

## Descripción
Este repositorio contiene un proyecto de diseño de base de datos para un cliente, siguiendo todas las fases de desarrollo hasta la creación y prueba en MySQL. El objetivo es modelar, implementar y validar una base de datos relacional óptima, que satisfaga los requisitos del negocio y garantice integridad, escalabilidad y buen rendimiento.

---

## 📑 Tabla de Contenidos

- [Requisitos](#-requisitos)  
- [Fases del Proyecto](#-fases-del-proyecto)  
  - [1. Recolección de Requisitos](#1-recolección-de-requisitos)  
  - [2. Diseño Conceptual](#2-diseño-conceptual)  
  - [3. Diseño Lógico](#3-diseño-lógico)  
  - [4. Diseño Físico](#4-diseño-físico)  
  - [5. Implementación en MySQL](#5-implementación-en-mysql)  
  - [6. Pruebas y Validación](#6-pruebas-y-validación)  
- [Estructura del Repositorio](#-estructura-del-repositorio)  
- [Instalación y Uso](#-instalación-y-uso)  
- [Contribuciones](#-contribuciones)  
- [Licencia](#-licencia)

---

## 📝 Requisitos

- **MySQL 8.0+**  
- **MySQL Workbench** (opcional, para diagramas y administración)  
- **Git**  
- **Sistema operativo**: Windows, Linux o macOS  

---

## 🔄 Fases del Proyecto

### 1. Recolección de Requisitos
- Entrevistas con el cliente  
- Identificación de entidades y procesos clave  
- Definición de reglas de negocio y restricciones  

**Entregables**: Documento de requisitos funcionales y no funcionales (`docs/requisitos.md`).

### 2. Diseño Conceptual
- Creación de Diagrama Entidad–Relación (ER)  
- Definición de entidades, atributos y relaciones  
- Validación con el cliente

**Entregables**: Diagrama ER en PDF/PNG (`docs/ER_diagram.png`).

### 3. Diseño Lógico
- Transformación del modelo ER a un modelo relacional  
- Definición de tablas, claves primarias y foráneas  
- Normalización (hasta 3FN o BCNF según corresponda)

**Entregables**: Script de creación de tablas lógico (`sql/01_logical_schema.sql`).

### 4. Diseño Físico
- Ajustes de tipos de datos según MySQL  
- Definición de índices, vistas y procedimientos almacenados  
- Plan de particionamiento (si aplica)

**Entregables**: Script de esquema físico y optimizaciones (`sql/02_physical_schema.sql`).

### 5. Implementación en MySQL
- Creación de la base de datos  
- Ejecución de scripts DDL y DML de muestra  
- Poblado inicial de datos de prueba

**Entregables**:  
- `sql/03_create_database.sql`  
- `sql/04_seed_data.sql`

### 6. Pruebas y Validación
- Pruebas de integridad referencial  
- Pruebas de consultas de negocio (SELECT, JOIN, agregaciones)  
- Pruebas de rendimiento y optimización de consultas  
- Documentación de resultados

**Entregables**: Reporte de pruebas (`docs/tests_report.md`) y scripts de prueba (`sql/05_test_queries.sql`).

---

## 🗂️ Estructura del Repositorio
