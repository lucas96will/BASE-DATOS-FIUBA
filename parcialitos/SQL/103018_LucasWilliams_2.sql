-- Obtener el padrón y apellido de aquellos alumnos que tienen nota en las materias
-- 75.40 y 75.41 y no tienen nota ni en la materia 62.05 ni en 75.01.


SELECT DISTINCT n.padron, a.apellido
FROM notas n 
LEFT JOIN alumnos a USING(padron)
WHERE 
    n.codigo = 75 AND 
    (n.numero = 40 OR n.numero = 41) AND
    n.padron NOT IN (
        SELECT padron
        FROM notas n
        WHERE
            (n.codigo = 62 AND n.numero = 05) OR
            (n.codigo = 75 AND n.numero = 01)  
    )


-- Resultados --
-- <Texto del resultado>

padron	apellido
83000	Gomez
84000	Lopez
85000	Fernandez