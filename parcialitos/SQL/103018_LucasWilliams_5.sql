-- Para cada nota del alumno con la fecha de ingreso más reciente, mostrar su padrón, 
-- código de departamento, número de materia y el valor de la nota.

-- Nota: En caso de que sean más de uno los alumnos con la fecha de ingreso más reciente, 
-- mostrar dichos datos para todos esos alumnos.

-- Nota 2: Si bien en la realidad puede darse que los valores de padrón sean estrictamente 
-- crecientes en el tiempo. NO utilizar este criterio para determinar al alumno con la fecha de ingreso más reciente.

SELECT 
    DISTINCT n.padron, 
    n.codigo as cod_departamento, 
    n.numero as num_materia,
    n.nota,
    n.fecha
FROM notas n
WHERE n.fecha = (
    SELECT MAX(n2.fecha)
    FROM notas n2
    WHERE n2.padron = n.padron
)

SELECT n.padron, n.codigo, n.numero,  n.nota
FROM notas n
INNER JOIN alumnos a USING(padron)
GROUP BY n.fecha, n.padron, n.codigo, n.numero, n.nota
HAVING n.fecha >= ALL (
    SELECT n.fecha
    FROM notas n 
    GROUP BY n.fecha
    ORDER BY n.fecha DESC
    LIMIT 1
    )


-- Resultados --
-- <Texto del resultado>

-- padron	cod_departamento	num_materia	nota	fecha
-- 71000	71	14	7	2013-07-10
-- 72000	71	15	2	2013-12-09
-- 73000	71	15	9	2014-07-07
-- 75000	71	15	2	2014-07-07
-- 76000	75	15	10	2013-07-24
-- 77000	61	2	9	2015-12-15
-- 78000	62	5	6	2015-07-10
-- 79000	61	2	8	2016-07-20
-- 80000	61	2	8	2017-07-10
-- 81000	61	1	9	2016-07-22
-- 82000	61	2	6	2018-07-20
-- 83000	71	13	9	2016-07-07
-- 84000	71	13	7	2016-07-15
-- 85000	71	13	8	2016-12-18
-- 86000	71	15	9	2017-07-07
-- 87000	71	15	7	2017-07-15
-- 88000	71	14	8	2017-12-18