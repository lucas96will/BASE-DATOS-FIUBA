-- Mostrar el padrón, apellido y promedio para aquellos alumnos 
-- que tienen nota en más de 4 materias y un promedio de al menos 6.

SELECT a.padron, a.apellido, padrones_validos.promedio
FROM (
    SELECT n.padron, AVG(n.nota) as promedio
    FROM notas n
    GROUP BY n.padron
    HAVING AVG(n.nota) >= 6 AND COUNT(n.nota) > 4
) as padrones_validos
INNER JOIN alumnos a ON a.padron = padrones_validos.padron

-- Resultados --
-- <Texto del resultado>
padron	apellido	promedio
73000	Molina	6.6000000000000000
86000	Diaz	7.8000000000000000