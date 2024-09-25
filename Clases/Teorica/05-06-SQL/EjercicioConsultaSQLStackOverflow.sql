https://data.stackexchange.com/stackoverflow/query/new

Ej 0
Liste los nombres de badges que otorga StackOverflow y que no estén basados en tags (Tagbased = 0)

SELECT DISTINCT Name
FROM Badges
WHERE TagBased = 0

Ej 1
Liste los tags que utilizó el usuario “Jon Skeet”

SELECT DISTINCT t.TagName
FROM Users u, PostTags pt, Posts p, Tags t
WHERE u.DisplayName = 'Jon Skeet' -- filtro usuario
AND u.Id = p.OwnerUserId -- condiciones de join
AND p.Id = pt.PostId
AND pt.TagId = t.Id

Ej 2
Listar los tags por orden y obtener solo los 10 primeros

SELECT DISTINCT t.TagName
FROM Users u, PostTags pt, Posts p, Tags t
WHERE u.DisplayName = 'Jon Skeet' -- filtro usuario
AND u.Id = p.OwnerUserId -- condiciones de join
AND p.Id = pt.PostId
AND pt.TagId = t.Id
ORDER BY t.TagName
OFFSET 0 ROWS
FETCH FIRST 10 ROWS ONLY

Ej 3
Para las preguntas hechas desde el 01/01/2024 en adelante,
muestre las 10 que recibieron más visitas, indicando su título,
la fecha en la que se hicieron y la cantidad de visitas que
recibieron

SELECT p.Title, p.CreationDate, p.ViewCount
FROM Posts p
WHERE p.ParentId IS NULL -- Es una pregunta
AND p.CreationDate >= '2024-01-01'
ORDER BY p.ViewCount DESC
OFFSET 0 ROWS
FETCH FIRST 10 ROWS ONLY


Reecho el ej 2
SELECT DISTINCT t.TagName
FROM Users u INNER JOIN Posts p ON u.Id = p.OwnerUserId -- condiciones de join
             INNER JOIN PostTags pt ON p.Id = pt.PostId
             INNER JOIN Tags t ON pt.TagId = t.Id
WHERE u.DisplayName = 'Jon Skeet' -- filtro usuario
ORDER BY t.TagName
OFFSET 0 ROWS
FETCH FIRST 10 ROWS ONLY


DML - Ejercicio 4
Utilizando el JOIN, devuelva los posts que utilizan tags
‘relational’ y ‘entity-relationship’, indicando el id del post, el
título y la cantidad de vistas.

SELECT p.Id, p.Title, p.ViewCount
FROM Posts p INNER JOIN PostTags pt ON p.id = pt.PostId
             INNER JOIN Tags t ON t.Id = pt.TagId
             INNER JOIN PostTags pt2 ON p.id = pt2.PostId
             INNER JOIN Tags t2 ON t2.id = pt2.TagId
WHERE t.TagName = 'relational'
AND t2.TagName = 'entity-relationship'


DML - Ejercicio 5
Utilizando subconsultas, devuelva los posts que utilizan el tag
‘relational’ y no utilizan el tag ‘entity-relationship’, indicando el
id del post, el título y la cantidad de vistas.

SELECT p.Id, p.Title, p.ViewCount
FROM Posts p INNER JOIN PostTags pt ON p.id = pt.PostId
INNER JOIN Tags t ON t.Id = pt.TagId
WHERE t.TagName = 'relational'
AND p.Id <> ALL (
SELECT Pt2.PostId
FROM PostTags Pt2 INNER JOIN Tags t2 ON t2.id = pt2.TagId
WHERE t2.TagName = 'entity-relationship'
)

DML - Ejercicio 6
Encuentre para cada Tag la/s pregunta/s que haya/n tenido la mayor
cantidad de vistas, indicando el nombre del tag y el título y cantidad de
vistas de las preguntas.
Sólo muestre tags de preguntas con al menos 2 millones de vistas

SELECT t.TagName, p.Title, p.ViewCount
FROM Tags t INNER JOIN PostTags pt ON t.id = pt.TagId
INNER JOIN Posts p ON p.Id = pt.PostId
WHERE p.ParentId IS NULL -- Pregunta
AND p.ViewCount >= 2000000
AND p.ViewCount >= ALL (
  SELECT p2.ViewCount
  FROM PostTags pt2
  INNER JOIN Posts p2 ON p2.Id = pt2.PostId
  WHERE p2.ParentId IS NULL -- Pregunta
  AND p2.ViewCount >= 2000000
  AND pt2.TagId = t.Id
)



DML - Ejercicio 7 y 8
Cuente la cantidad de usuarios existentes en la base

SELECT COUNT(*)
FROM Users u

Cuente la cantidad de Posts que son preguntas

SELECT COUNT(*)
FROM Posts p
WHERE p.ParentId IS NULL




