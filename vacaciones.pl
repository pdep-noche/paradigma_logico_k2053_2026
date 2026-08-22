%viajaA(persona, destino).
viajaA(dodain, pehuenia).
viajaA(dodain, sanMartin).
viajaA(dodain, esquel).
viajaA(dodain, sarmiento).
viajaA(dodain, camarones).
viajaA(dodain, playasDoradas).
viajaA(alf, sanMartin).
viajaA(alf, elBolson).
viajaA(alf, bariloche).
viajaA(nico, marDelPlata).
viajaA(vale, calafate).
viajaA(vale, elBolson).
viajaA(martu, Destino):-viajaA(nico, Destino).
viajaA(martu, Destino):-viajaA(alf, Destino).
viajaA(ana, pehuenia).
viajaA(ana, esquel).

%Punto 2
tieneAtraccion(esquel, parqueNacional(losAlerces)).
tieneAtraccion(esquel, excursion(trochita)).
tieneAtraccion(esquel, excursion(trevelin)).
tieneAtraccion(pehuenia, cerro(bateaMahuida, 2000)).
tieneAtraccion(pehuenia, cuerpoDeAgua(moquehue,puedePescar, 14)).
tieneAtraccion(pehuenia, cuerpoDeAgua(alumine, puedePescar, 19)).

persona(Persona):-viajaA(Persona, _).

vacacionesCopadasPara(Persona):- persona(Persona), 
    forall(viajaA(Persona, Destino), tieneUnaAtraccionCopada(Destino)).

tieneUnaAtraccionCopada(Destino):- tieneAtraccion(Destino, Atraccion), 
            esCopada(Atraccion).

%Polimorfismo
esCopada(cerro(_, Altura)):- Altura > 2000.
esCopada(cuerpoDeAgua(_,puedePescar, _)).
esCopada(cuerpoDeAgua(_, _, Temperatura)):- Temperatura >20.
esCopada(playa(Diferencia)):- Diferencia < 5.
esCopada(excursion(Nombre)):-atom_length(Nombre, Length), Length > 7.
esCopada(parqueNacional(_)).


%Punto 3
noSeCruzaron(Persona, OtraPersona):- persona(Persona), persona(OtraPersona), Persona \= OtraPersona, 
    not(seCruzaron(Persona, OtraPersona)).

seCruzaron(Persona, OtraPersona):-viajaA(Persona, Destino), viajaA(OtraPersona, Destino).


%Punto 4
fueronGasoleras(Persona):-persona(Persona), 
        forall(viajaA(Persona, Lugar), esGasolero(Lugar)).


esGasolero(Lugar):-costoDeVida(Lugar, Costo), Costo < 160.

costoDeVida(sarmiento, 100).
costoDeVida(esquel, 150).
costoDeVida(pehuenia, 180).
costoDeVida(sanMartin, 150).
costoDeVida(camarones, 135).
costoDeVida(playasDoradas, 170).
costoDeVida(bariloche, 140).
costoDeVida(elCalafate, 240).
costoDeVida(elBolson, 145).
costoDeVida(marDelPlata, 140).

%Punto 5
itinerarionPosibles(Persona, Destinos):-persona(Persona), 
    findall(Lugar, viajaA(Persona, Lugar), Lugares), 
    permutacion(Lugares, Destinos).

permutacion([], []).
permutacion(Lista, [Elem|OtraLista]):- 
    eliminar(Elem, Lista, Resto), 
    permutacion(Resto, OtraLista). 

eliminar(Elem, [Elem| Resto], Resto).
eliminar(Elem, [OtroElem| Lista], [OtroElem|Resto]):-
        eliminar(Elem, Lista, Resto).    