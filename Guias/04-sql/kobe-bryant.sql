-- a) Encuentre la cantidad de partidos en que Kobe Bryant marc´o al menos 50 puntos,
-- devolviendo ´unicamente dicha cantidad.

-- b) Kobe Bryant lleg´o a convertir 5640 puntos en los playoffs. Encuentre a aquellos jugadores que hayan
-- superado la marca de 5640 puntos, indicando para cada uno su
-- nombre y la cantidad de puntos que convirti´o en playoffs.
-- Nota: Los playoffs son una etapa de la temporada. La etapa a la que corresponde cada partido se
-- indica bajo el atributo stage.

-- c) Encuentre la cantidad de puntos que marc´o Kobe Bryant en el ´ultimo partido oficial
-- que jug´o, indicando el nombre del equipo local, el nombre del equipo visitante y la
-- cantidad de puntos marcados por Kobe.

-- a)

SELECT COUNT(1) as cant_partidos
FROM Actions
WHERE 
    player_name == 'Kobe Bryant' and
    points > 50

-- b)

SELECT a.player_name, SUM(a.points)
FROM Actions a
INNER JOIN Matches m Using(match_id)
WHERE m.stage_name = 'playoffs'
GROUP BY a.player_name, a.points
HAVING SUM(a.points) > 5640

-- c)

SELECT ultimo_partido.local_team, ultimo_partido.visiting_team, a.points as puntos_kobe
FROM Actions a 
INNER JOIN (
    SELECT m.match_id, m.local_team, m.visiting_team
    FROM Matches m 
    GROUP BY match_id, m.date, m.local_team, m.visiting_team
    ORDER BY m.date DESC 
) as ultimo_partido on 
    a.match_id = ultimo_partido.match_id
WHERE a.player_name = 'Kobe Bryant'
