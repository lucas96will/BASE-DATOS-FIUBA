-- usando not exists para obtener la cantidad de alumnos que no tienen notas en alguna materia -- dificil
select distinct padron 
from alumnos
left join notas n1 using(padron)
where not exists (
  SELECT 1
  from materias m
  where not exists (codigo, numero) NOT IN (
    SELECT 1
    from notas n 
    where 
      n2.padron = n1.padron
      and m.codigo = n2.codigo 
      and m.numero = n2.numero 
  )
)  


-- pasaje a not in sale mal
select padron 
from alumnos
left join notas n1 using(padron)
where (codigo, numero, padron) not in (
  SELECT codigo, numero, n3.padron
  from materias m
  left join notas n3 using(codigo, numero)
  where (m.codigo, m.numero, n3.padron) not in (
    SELECT n2.codigo, n2.numero, n2.padron
    from notas n2
    where 
      n2.padron = n1.padron
      and m.codigo = n2.codigo 
      and m.numero = n2.numero 
  )
)

-- RESTA -- ineficiente
-- un join con las materias con alumno, le resto las notas de materia que existen 
-- si la resta no tiene nada, entonces el alumno tiene notas en todas las materias 

select padron
from alumnos
where not exists (
    select padron from (
    select padron, codigo, numero
    from alumnos 
    cross join materias -- recordar que es a*b registros, un monton!
    except 
    select padron, codigo, numero 
    from notas
  ) falta_rendir
  where falta_rendir.padron = alumnos.padron
)

-- con AGRUPACION -- bien sql
-- comparar cantidad de materias (distintas) en las que cada alumno tiene nota 
-- cantidad total de materias 
-- si un alumno tiene nota en todas las materias, las dos cantidades son iguales 

select 
  nombre, 
  padron, 
  count(distinct (codigo, numero)) as cant_materias,
  count(nota) cant_notas
from alumnos 
inner join notas using(padron) -- on n.padron = a.padron
group by padron 
having (
  select count(1)
  from materias
) -- = COUNT(distinct (to_char(codigo, ...) || '.' || to_char(numero, ...)))
=
count(distinct (codigo, numero))

-------------------------------------------------------------------
-- ejercicios de parcial 

select matricula, marca, modelo
from vehiculo v 
join propietario p using(matricula)
join persona pe using(dni) -- and lower(pe.ciudad) <> 'cordoba'
where v.matricula in
  (
  select matricula
  from multa
  where 
    importe < 200000 and 
    fecha between '2022-07-01' and '2022-08-01'
) and lower(pe.ciudad) <> 'cordoba'


select dni, matricula, max(m.importe) as mayor_importe_a_pagar
from propietarios p 
join multa m on p.matricula = m.matricula 
where fecha between '2022-01-01' and '2022-12-31'
group by p.dni, p.matricula
order by mayor_importe_a_pagar desc
