-- FUNCIONES ALMACENADAS
-- Función 1: Obtener la cantidad de trámites activos (pendientes o en proceso) de un cliente
DELIMITER //
CREATE FUNCTION contar_tramites_activos(cliente_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total 
    FROM tramite 
    WHERE id_cliente = cliente_id AND estado IN ('pendiente', 'en proceso');
    RETURN total;
END;
//
DELIMITER ;

-- Prueba:

SELECT contar_tramites_activos(1) AS total_tramites_activos;


-- Función 2: Obtener el nombre completo del gestor dado su id_gestor
DELIMITER //

CREATE FUNCTION nombre_gestor(id INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE nombre VARCHAR(100);
    SELECT nombre_completo INTO nombre FROM gestor WHERE id_gestor = id;
    RETURN nombre;
END;
//

DELIMITER ;

-- Prueba:

SELECT nombre_gestor(1) AS nombre_completo_gestor;



-- PROCEDIMIENTOS ALMACENADOS
-- Procedimiento 1: Actualizar el estado de un trámite
DELIMITER //

CREATE PROCEDURE actualizar_estado_tramite(
    IN p_id_tramite INT,
    IN p_nuevo_estado ENUM('pendiente', 'en proceso', 'completado')
)
BEGIN
    UPDATE tramite 
    SET estado = p_nuevo_estado 
    WHERE id_tramite = p_id_tramite;
END;
//
DELIMITER ;

-- Prueba:
-- Cambiar estado de un trámite con id_tramite = 1 a 'completado'
CALL actualizar_estado_tramite(1, 'completado');

-- Procedimiento 2: Insertar nueva alerta para un trámite
DELIMITER //

CREATE PROCEDURE insertar_alerta(
    IN p_id_tramite INT,
    IN p_tipo_alerta VARCHAR(100),
    IN p_descripcion VARCHAR(100),
    IN p_fecha_alerta DATE
)
BEGIN
    INSERT INTO alerta (id_tramite, tipo_alerta, descripcion, fecha_alerta)
    VALUES (p_id_tramite, p_tipo_alerta, p_descripcion, p_fecha_alerta);
END;
//
DELIMITER ;

-- Prueba:

-- Insertar una alerta para el trámite 1
CALL insertar_alerta(1, 'Recordatorio', 'Revisar documentos necesarios', CURDATE());


-- TRIGGERS:
-- Trigger BEFORE UPDATE: Antes de cambiar el estado del trámite, guarda un historial
DELIMITER //

CREATE TRIGGER before_tramite_update
BEFORE UPDATE ON tramite
FOR EACH ROW
BEGIN
    IF OLD.estado <> NEW.estado THEN
        INSERT INTO historial_cambios (id_tramite, usuario_modifico, descripcion, estado_anterior, estado_nuevo)
        VALUES (OLD.id_tramite, NULL, CONCAT('Cambio de estado de ', OLD.estado, ' a ', NEW.estado), OLD.estado, NEW.estado);
        -- Nota: usuario_modifico es NULL aquí porque el trigger no recibe info de usuario; idealmente se pasa desde la app.
    END IF;
END;
//
DELIMITER ;


-- Prueba:

UPDATE tramite SET estado = 'en proceso' WHERE id_tramite = 1;

-- Verificacion:

SELECT * FROM tramite WHERE id_tramite = 1;


-- Trigger AFTER INSERT: Después de insertar un nuevo trámite, crea una alerta automática de seguimiento

DELIMITER //

CREATE TRIGGER after_tramite_insert
AFTER INSERT ON tramite
FOR EACH ROW
BEGIN
    INSERT INTO alerta (id_tramite, tipo_alerta, descripcion, fecha_alerta, atendida)
    VALUES (NEW.id_tramite, 'Recordatorio', 'Revisar estado del trámite', DATE_ADD(CURDATE(), INTERVAL 7 DAY), FALSE);
END;
//

DELIMITER ;

-- Prueba:

INSERT INTO tramite (
    id_cliente, id_gestor, tipo_tramite, estado, fecha_inicio, fecha_cita, fecha_vencimiento, fecha_resolucion, observaciones
) VALUES (
    1, 1, 'Renovación NIE', 'pendiente', CURDATE(), NULL, DATE_ADD(CURDATE(), INTERVAL 30 DAY), NULL, 'Primer trámite'
);


-- Verificacion:

SELECT * FROM historial_cambios WHERE id_tramite = 1;
SELECT * FROM alerta WHERE id_tramite = 1;



