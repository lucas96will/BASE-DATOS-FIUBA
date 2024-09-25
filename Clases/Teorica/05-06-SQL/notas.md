https://data.stackexchange.com/stackoverflow/query/new
-> elegir stackoverflow.es

# 17 sep 24

# SQL

### Ejericio 9
Muestre los nombres de los 10 usuarios cuyas respuestas a preguntas
taggeadas con 'C#' acumulan mayor puntaje

SELECT u.DisplayName
FROM Posts preg INNER JOIN Posts rta ON preg.Id = rta.ParentId
INNER JOIN PostTags pt ON pt.PostId = preg.Id
INNER JOIN Tags t ON t.Id = pt.TagId
INNER JOIN Users u ON u.Id = rta.OwnerUserId
WHERE t.tagName = 'c#'
GROUP BY u.Id, u.DisplayName
ORDER BY SUM(rta.Score) DESC
OFFSET 0 ROWS FETCH FIRST 10 ROWS ONLY

### Ejercicio 10
Encuentre el Id, el título y la cantidad de vistas de la/s pregunta/s que
haya/n tenido la mayor cantidad de vistas.

SELECT Id, Title, ViewCount
FROM Posts 
WHERE ParentId IS NULL
AND ViewCount = (
   SELECT MAX(ViewCount)
  FROM Posts WHERE ParentId IS NULL )

### Ejercicio 11

Liste los tags cuyo primer uso ocurrió después del 01/01/2018.

SELECT t.Id, t.TagName
FROM Tags t INNER JOIN PostTags pt ON t.Id = pt.TagId
INNER JOIN Posts p ON pt.PostId = p.Id
GROUP BY t.Id, t.TagName
HAVING MIN(p.CreationDate) > '2018-01-01'

### Ej nuevo
Para cada posteo de Pablo Lozano cuantos tags tiene, devolviendo unicamente posts con mas de 1 tag

SELECT p.Id, p.Title, COUNT(*)
FROM Tags t INNER JOIN PostTags pt ON t.Id = pt.TagId
INNER JOIN Posts p ON pt.PostId = p.Id
INNER JOIN Users u ON u.Id = p.OwnerUserId
WHERE u.DisplayName = 'Pablo Lozano'
GROUP BY p.Id, p.Title
HAVING COUNT(*) > 1

Cuales son los posteos que tienen la mayor cantidad de tags?

SELECT p.Id, p.Title, COUNT(*)
FROM Tags t INNER JOIN PostTags pt ON t.Id = pt.TagId
INNER JOIN Posts p ON pt.PostId = p.Id
INNER JOIN Users u ON u.Id = p.OwnerUserId
WHERE u.DisplayName = 'Pablo Lozano'
GROUP BY p.Id, p.Title
HAVING COUNT(*) >= ALL (
  SELECT COUNT(*)
  FROM Tags t INNER JOIN PostTags pt ON t.Id = pt.TagId
  INNER JOIN Posts p ON pt.PostId = p.Id
  INNER JOIN Users u ON u.Id = p.OwnerUserId
  WHERE u.DisplayName = 'Pablo Lozano'
  GROUP BY p.Id, p.Title
)

## ABMS

En el alta no usar max o +1

En el update, no olvidarse el where

En el borrado, no olvidarse el where

Transacciones, son muy complicadas por problemas no relacionadas.
- Que sucede si dos personas acceden a la misma transaccion
- Que sucede si se corta la luz

## Vistas

Una tabla virtual
- Se las puede acceder como si fueran una tabla mas
- No existe fisicamente como una tabla, sus datos surgen como una consulta sobre una o mas tablas
``` CREATE VIEW nombre_vista
    [ (columna1, ... , ColumnaN)]
    AS consulta_sql
```

Usos de la vista:
- Seguridad: no mostrar ciertas filas / columnas
- reduccion de complejidad: representar consultas complejas
- Cambios de representacion de datos: usar vistas con version vieja


### WITH y WITH RECURSIVE
Define un alias a la consulta, pero solo existe durante la ejecucion de la consulta
Se conoce como CTE (Common table expression)

Ej nuevo (segunda parte)
WITH PostsDeLozano AS (
  SELECT p.Id, p.Title, COUNT(*) AS cant_tags
  FROM Tags t INNER JOIN PostTags pt ON t.Id = pt.TagId
  INNER JOIN Posts p ON pt.PostId = p.Id
  INNER JOIN Users u ON u.Id = p.OwnerUserId
  WHERE u.DisplayName = 'Pablo Lozano'
  GROUP BY p.Id, p.Title
)

SELECT * FROM PostsDeLozano
WHERE cant_tags >= ALL (SELECT cant_tags FROM PostsDeLozano)

With recursive
- Permite que una subconsulta se referencie a si misma
- Esto es util para resolver consultas iterativas

Basicamente es una consulta que se referencia a si misma, se sigue ejecutando hasta no encontrar una nueva respuesta.

WITH RECURSIVE alias [(col1, ..., colN)]
AS (
    SELECT ... FROM ... / esto es la consulta inicial fija
    UNION
    SELECT ... FROM ... / esto es la consulta recursiva, que utiliza a alias, referenciandose
)
SELECT ... FROM ...;

