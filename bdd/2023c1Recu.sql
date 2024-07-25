-- 1)
RIP
-- 2)
SELECT cod_hotel, COALESCE(SUM(cantidad), 0) as cant_vent FROM habitaciones LEFT JOIN equipamientos USING(cod_hotel, numero) WHERE tipo_equipamiento = 'VENTILADOR' GROUP BY cod_hotel;