1. (Clausura de conjuntos de atributos y de conjuntos de dependencias) Dado el esquema
de relacion R(A, B, C, D, E) y el siguiente conjunto de dependencias funcionales asociado
F = {AB → D, CD → E, A → C, D → B, BC → A}, indique si cada una de las
siguientes dependencias funcionales pertenece a la clausura de F.
a) BC → AD
b) BD → DC
c) CA → B
d) BC → DE

a) 
BC+ = {B, C, A, D, E}
La dependencia funcional BC -> AD pertenece a la clausura de F

b)
BD+ = {B, D}
La dependencia funcional BD -> DC no pertenece a la clausura de F

c)
CA+ = {C, A}
La dependencia funcional CA -> B no pertenece a la clausura de F

d) idem ejercicio a)
BC+ = {B, C, A, D, E}
La dependencia funcional BC -> DE pertenece a la clausura de F

2. (Dise˜no conceptual y relacional) Una firma de agentes de bolsa ofrece a sus clientes la
posibilidad de invertir en acciones. La firma est´a compuesta por varios agentes de bolsa
(B) y tiene varias oficinas (O). Cada agente de bolsa opera en a lo sumo una oficina.
Cada cliente inversor (I) es gestionado por un y s´olo un agente de bolsa, y puede poseer
acciones de muchas compa˜n´ıas (A). La firma almacena para cada inversor la cantidad de
acciones (Q) que posee de una compa˜n´ıa dada, y almacena tambi´en para cada acci´on de
una compa˜n´ıa su cotizaci´on actual (P) y el monto de dividendos anuales (D) que la misma
paga. Se pide:
a) Escriba un conjunto de dependencias funcionales F que represente todas las restricciones de la empresa.
b) A partir del conjunto F definido, encuentre las claves candidatas de la relaci´on universal R(B, O, I, A, Q, P, D).
c) Utilizando el algoritmo correspondiente, encuentre una descomposici´on de R en FNBC
sin p´erdida de informaci´on. Indique si se preservaron todas las dependencias funcionales.
d) Considere la descomposici´on de R en R1(I, A, Q, P, D) y R2(I, B, O). Indique en qu´e
forma normal se encuentra cada una de estas dos relaciones, si se preserva la informaci´on, y si se preservan todas las dependencias funcionales.

R(B, O, I, A, Q, P, D)

F = {
    B -> O, 
    I -> B, 
    IA-> Q, 
    A -> PD
    }