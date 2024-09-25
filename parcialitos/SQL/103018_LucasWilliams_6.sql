-- Listar el padrón de aquellos alumnos que, por lo menos, 
-- tienen nota en todas las materias que aprobó el alumno del padrón 83000.


SELECT n.padron
FROM notas n
JOIN (
    SELECT n2.codigo, n2.numero
    FROM notas n2
    WHERE n2.padron = '83000' AND n2.nota >= 4
) AS notas_83000
ON n.codigo = notas_83000.codigo AND n.numero = notas_83000.numero
WHERE n.padron <> '83000'
GROUP BY n.padron
HAVING COUNT(DISTINCT(n.codigo, n.numero)) >= (
    SELECT COUNT(1)
    FROM notas n3
    WHERE n3.padron = n.padron
)


-- Resultados --
-- <Texto del resultado>

padron
84000
85000