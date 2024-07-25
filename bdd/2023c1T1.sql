-- 1)
SELECT cod_hotel, nombre FROM hoteles WHERE cod_hotel in (
  SELECT cod_hotel FROM reservas WHERE fecha >= '2022-09-01' and fecha <= '2022-09-30' 
  GROUP BY cod_hotel HAVING COUNT(DISTINCT tipo_doc || TO_CHAR(nro_doc, 'fm00000000') ) >= 5 
) and cod_hotel not in (
  SELECT cod_hotel FROM reservas WHERE fecha >= '2022-10-01' and fecha <= '2022-10-31'
)

-- 2)
SELECT cod_hotel, fecha, nombre FROM reservas JOIN (SELECT cod_hotel, MIN(fecha) as fecha FROM reservas WHERE numero = 100 GROUP BY cod_hotel) as aux USING(cod_hotel, fecha)