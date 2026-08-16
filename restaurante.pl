%viveEn(rata, lugar).
viveEn(remy, gusteaus).
viveEn(emile, chezMilleBar).
viveEn(django, pizzeriaJeSuis).

%sabeCocinar(cocinero, plato, puntuacion)
sabeCocinar(linguini, ratatoullie, 3).
sabeCocinar(linguini, sopa, 5).
sabeCocinar(colette, salmonRosado, 9).
sabeCocinar(horst, ensaladaRusa, 8).


%trabajaEn(cocinero, restaurante)
trabajaEn(linguini, gusteaus).
trabajaEn(colette, gusteaus).
trabajaEn(horst, gusteaus).
trabajaEn(skinner, gusteaus).
trabajaEn(amelie, cafeDes2Moulins).


%1
estaEnElMenu(Plato, Restaurante):- sabeCocinar(Persona, Plato, _), 
    trabajaEn(Persona, Restaurante).


%2
cocinaBien(Cocinero, Plato):-sabeCocinar(Cocinero, Plato, Experiencia), Experiencia > 7.
cocinaBien(Cocinero, Plato):-sabeCocinar(Cocinero, Plato, _), tieneTutor(Cocinero, Tutor), 
                            cocinaBien(Tutor, Plato).
cocinaBien(remy, Plato):-sabeCocinar(_, Plato, _).

tieneTutor(linguini, Rata):- trabajaEn(linguini, Resto), viveEn(Rata, Resto).
tieneTutor(skinner, amelie).

%3
esChefDe(Cocinero, Restaurante):- trabajaEn(Cocinero, Restaurante), 
                           cumpleCondicionChef(Cocinero, Restaurante). 


cumpleCondicionChef(Cocinero, Restaurante):-
       forall(estaEnElMenu(Plato, Restaurante), cocinaBien(Cocinero, Plato)).
cumpleCondicionChef(Cocinero, _):- totalExperiencia(Cocinero, Total), Total >= 20.


totalExperiencia(Cocinero, Total):- 
    findall(Experiencia, sabeCocinar(Cocinero,_,  Experiencia), ListaExperiencias), 
    sumlist(ListaExperiencias, Total).


%4
encargadoDe(Persona, Plato, Resto):-experienciaCocinero(Persona, Plato, Resto, Experiencia), 
    forall(experienciaCocinero(_, Plato, Resto, OtraExperiencia), Experiencia >= OtraExperiencia).

experienciaCocinero(Persona, Plato, Resto, Experiencia):- trabajaEn(Persona, Resto), 
    sabeCocinar(Persona, Plato, Experiencia).

%5

plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 20)).
plato(frutillasConCrema, postre(265)).

esSaludable(NombrePlato):- plato(NombrePlato, TipoPlato),  caloriasDe(TipoPlato, Calorias), Calorias < 75.


% Hay Polimorfismo
caloriasDe(entrada(Ingredientes), Calorias):- length(Ingredientes, Total), Calorias is Total * 15.
caloriasDe(principal(Guarnicion, Minutos), Calorias):- caloriasDeGuarnicion(Guarnicion, CaloriasGuarnicion), 
                    Calorias is (Minutos * 5) + CaloriasGuarnicion.
caloriasDe(postre(Calorias), Calorias).                

caloriasDeGuarnicion(papasFritas, 50).
caloriasDeGuarnicion(pure, 20).
caloriasDeGuarnicion(ensalada ,0).


%6
hizoReseniaPositiva(Critico, Resto):- restaurante(Resto), not(viveEn(_, Resto)), 
                                criterioCritico(Critico, Resto).


restaurante(Resto):- trabajaEn(_, Resto).

criterioCritico(antonEgo, Resto):-esEspecialista(Resto, ratatoullie).
criterioCritico(cormillot, Resto):- todosLosPlatosSaludables(Resto).
criterioCritico(martiniano, Resto):- esChefDe(Cocinero, Resto), 
    not((esChefDe(OtroCocinero, Resto), OtroCocinero \= Cocinero)).

esEspecialista(Restaurante, NombrePlato):- 
    forall(esChefDe(Cocinero, Restaurante), cocinaBien(Cocinero, NombrePlato)).
todosLosPlatosSaludables(Resto):- forall(estaEnElMenu(NombrePlato, Resto), esSaludable(NombrePlato)).
