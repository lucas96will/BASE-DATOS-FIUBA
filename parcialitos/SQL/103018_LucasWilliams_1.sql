
-- Obtener el padrón y apellido de el/los alumno/s que tenga/n la mayor cantidad de materias promocionadas 
-- (asumiendo que se promociona si la nota es mayor o igual a 7).
-- Nota: Considerar la posibilidad de que sean más de uno.

-- Metodo de resolucion del ejercicio
    -- Consigo la cantidad de examenes con nota >= 7
    -- agrupo por padron
        -- condicion de cantidad de notas >= subquery
            -- la subquery deberia contener el dato de la mayor cantidad de materias promocionadas de un mismo padron


SELECT n.padron, a.apellido
FROM notas n
INNER JOIN alumnos a USING(padron)
WHERE n.nota >= 7
GROUP BY n.padron, a.apellido
HAVING COUNT(n.nota) >= ALL (
    SELECT COUNT(n.nota) as cant_promociones
    FROM notas n
    WHERE n.nota >= 7
    GROUP BY n.padron
    ORDER BY COUNT(n.nota) DESC
    LIMIT 1
)
ORDER BY n.padron


-- Resultados --
-- <Texto del resultado>
padron	apellido
83000	Gomez
85000	Fernandez
86000	Diaz
88000	Vargas