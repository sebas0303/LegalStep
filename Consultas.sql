
-- 1. Ver los trámites que están pendientes
	
SELECT id_tramite, tipo_tramite, estado 
FROM tramite
WHERE estado = 'pendiente';

-- 2. Consultar documentos que han sido validados
SELECT nombre_doc, estado 
FROM documento
WHERE estado = 'validado';


-- 3. Ver cuántos trámites tiene cada cliente
SELECT 
  c.nombre, 
  c.apellidos, 
  COUNT(t.id_tramite) AS total_tramites
FROM cliente c
LEFT JOIN tramite t ON c.id_cliente = t.id_cliente
GROUP BY c.id_cliente;

-- 4. Ver los trámites con vencimiento en los próximos 15 días
SELECT 
  t.tipo_tramite,
  t.fecha_vencimiento,
  c.nombre,
  c.apellidos
FROM tramite t
JOIN cliente c ON t.id_cliente = c.id_cliente
WHERE t.fecha_vencimiento BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), INTERVAL 15 DAY);


-- 5 Mostrar todos los clientes registrados

SELECT nombre, apellidos, pais_origen, email 
FROM cliente;


-- 6 Ver las alertas no atendidas

SELECT tipo_alerta, descripcion, fecha_alerta 
FROM alerta
WHERE atendida = false;


-- 7. Listar los gestores por especialidad

SELECT nombre_completo, especialidad 
FROM gestor;


-- 8 Obtener los trámites en proceso con nombre del cliente y del gestor asignado

SELECT 
  t.id_tramite,
  t.tipo_tramite,
  c.nombre AS nombre_cliente,
  g.nombre_completo AS gestor_asignado
FROM tramite t
JOIN cliente c ON t.id_cliente = c.id_cliente
LEFT JOIN gestor g ON t.id_gestor = g.id_gestor
WHERE t.estado = 'en proceso';


-- 9 Mostrar historial de cambios para un trámite específico

SELECT 
  hc.fecha_hora,
  u.nombre_usuario AS modificado_por,
  hc.descripcion,
  hc.estado_anterior,
  hc.estado_nuevo
FROM historial_cambios hc
JOIN usuario u ON hc.usuario_modifico = u.id_usuario
WHERE hc.id_tramite = 1
ORDER BY hc.fecha_hora DESC;


-- 10 Consultar documentos pendientes por cliente

SELECT 
  c.nombre, 
  c.apellidos, 
  d.nombre_doc
FROM cliente c
JOIN tramite t ON c.id_cliente = t.id_cliente
JOIN documento d ON t.id_tramite = d.id_tramite
WHERE d.estado = 'pendiente';

