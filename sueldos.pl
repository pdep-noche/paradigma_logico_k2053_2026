%PUNTO 1
%trabajaEn(Persona, Departamento)
trabajaEn(kyle, ventas).
trabajaEn(trisha, ventas).
trabajaEn(joshua, ventas).
trabajaEn(ian, logistica).
trabajaEn(sherri, logistica).

%puesto(Persona, TipoTrabajo, Sueldo)
% Tipo de Empleo: asalariado(horas), jefe(Subordinados), independiente(oficio) 
puesto(kyle, asalariado(6), 50).
puesto(sherri, asalariado(7), 60).
puesto(gus, asalariado(8), 60).
puesto(ian, jefe([kyle, rob, ginger]), 40).
puesto(trisha, jefe([ian, gus]), 90).
puesto(joshua, independiente(arquitecto), 55).

%Punto 2

departamento(Departamento):-trabajaEn(_, Departamento).

esPaganini(Departamento):- departamento(Departamento),  
    forall(trabajaEn(Persona, Departamento), ganaBien(Persona)).

ganaBien(Persona):-puesto(Persona, TipoEmpleo, Sueldo), cumpleCondicionGanaBien(TipoEmpleo, Sueldo).

sueldoPromedio(6, 45).
sueldoPromedio(7, 60).
sueldoPromedio(8, 80).

cumpleCondicionGanaBien(asalariado(Horas), Sueldo):- sueldoPromedio(Horas, Promedio), Sueldo > Promedio. 
cumpleCondicionGanaBien(jefe(Subordinados), Sueldo):-length(Subordinados, Cant),  Sueldo > 20 * Cant.
cumpleCondicionGanaBien(independiente(arquitecto), _).
cumpleCondicionGanaBien(independiente(_), Sueldo):- Sueldo > 70.

%Punto 3
%leGustaTrabajarEn(Persona, Departamento)
leGustaTrabajarEn(kyle, ventas).
leGustaTrabajarEn(kyle, logistica).
leGustaTrabajarEn(trisha, ventas).
leGustaTrabajarEn(joshua, ventas).
leGustaTrabajarEn(sherri, contabilidad).
leGustaTrabajarEn(sherri, facturacion).
leGustaTrabajarEn(sherri, cobranzas).

estaEnProblemas(Departamento):- departamento(Departamento), 
    not((trabajaEn(Persona, Departamento), leGustaTrabajarEn(Persona, Departamento))).


hayUnaPersonaQueNoLeGusta(Departamento):- trabajaEn(Persona, Departamento), 
            not(leGustaTrabajarEn(Persona, Departamento)).


 %Punto 5
 persona(Persona):-puesto(Persona, _, _).

 rearmarDepartamento(Presupuesto, Equipo, Sobrante):-equipoPosible(Equipo), 
    costoEquipo(Equipo, Costo), 
    Costo =< Presupuesto, 
    Sobrante is Presupuesto - Costo. 

equipoPosible(Equipo):- findall(Persona, persona(Persona), ListaPersonas), 
            subconjunto(ListaPersonas, Equipo), 
            length(Equipo, Cant), Cant>=2.            

subconjunto([], []).
subconjunto([Persona|Lista], [Persona|Resto]):- 
        subconjunto(Lista, Resto).
subconjunto([_|Personas], Equipo):-
        subconjunto(Personas, Equipo).


costoEquipo(Equipo, Costo):- findall(Sueldo, (member(Persona, Equipo), puesto(Persona, _, Sueldo)),  ListaSueldos),
                    sum_list(ListaSueldos, Costo).




