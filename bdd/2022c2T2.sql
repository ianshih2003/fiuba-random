-- 1)
WITH goles_por_equipo AS (
  SELECT 
  cod_eq1 as cod_eq, SUM(goles) as cant_goles FROM 
  (SELECT cod_eq1 as cod_eq, goles_eq1 goles FROM partidos
  UNION ALL
  SELECT cod_eq2 as cod_eq, goles_eq2 goles FROM partidos) as goles_aux GROUP BY cod_eq
)

SELECT nombre as cod_eq1, cant_goles FROM goles_por_equipo 
JOIN equipos USING(cod_eq) WHERE cant_goles = (SELECT MAX(cant_goles) FROM goles_por_equipo)

-- 2)
WITH goles_por_equipo AS (
  SELECT 
  cod_eq1 as cod_eq, SUM(goles) as cant_goles FROM 
  (SELECT cod_eq1 as cod_eq, SUM(goles_eq1) goles FROM partidos GROUP BY cod_eq1 WHERE fecha >= ALL (SELECT fecha FROM partidos)
  UNION ALL
  SELECT cod_eq2 as cod_eq, SUM(goles_eq2) as goles FROM partidos GROUP BY cod_eq2 WHERE fecha >= ALL (SELECT fecha FROM partidos)) as goles_aux GROUP BY cod_eq
)

SELECT nombre, equipos.cod_eq as cod_eq FROM goles_por_equipo 
JOIN equipos USING(cod_eq) WHERE cant_goles = (SELECT MAX(cant_goles) FROM goles_por_equipo)