progenitor(mona, homero).
progenitor(jaqueline, marge).
progenitor(marge, maggie).
progenitor(marge, bart).
progenitor(marge, lisa).
progenitor(abraham, herbert).
progenitor(abraham, homero).
progenitor(clancy, jaqueline).
progenitor(homero, maggie).
progenitor(homero, bart).
progenitor(homero, lisa).

ancestro(Ancestro, Descendiente):- progenitor(Ancestro, Descendiente).
ancestro(Ancestro, Descendiente):- progenitor(Progenitor, Descendiente), 
                            ancestro(Ancestro, Progenitor).
                            

ultimo([Elem], Elem).
ultimo([_|Cola], Elem):-ultimo(Cola, Elem). 

sumatoria([], 0).
sumatoria([Elem| Cola], Suma):- sumatoria(Cola, SumaCola), Suma is Elem + SumaCola.


encolar(Elem , [], [Elem] ).
encolar(Elem, [Cab| Cola], [Cab|Resto]):-encolar(Elem, Cola, Resto).


maximo(Lista, Maximo):- member(Maximo, Lista), 
    forall(member(OtroElem, Lista), OtroElem =< Maximo).


interseccion(Lista, OtraLista, Interseccion):- 
    findall(Elem, (member(Elem, Lista), member(Elem, OtraLista)), Interseccion).


esCreciente([_]).
esCreciente([Elem, OtroElem|Cola]):- Elem < OtroElem, 
                    esCreciente([OtroElem|Cola]).

sublistaMayoresA([], _, []).
sublistaMayoresA([Cab| Cola], Elem, [Cab| Resto]):-  Cab > Elem, 
                    sublistaMayoresA(Cola, Elem, Resto).
sublistaMayoresA([_|Cola], Elem, Lista ):- sublistaMayoresA(Cola, Elem, Lista).

genero(titanic,drama).
genero(gilbertGrape,drama).
genero(atrapameSiPuedes,comedia).
genero(ironMan,accion).
genero(rapidoYFurioso,accion).
genero(elProfesional,drama).

gusta(belen,titanic).
gusta(belen,gilbertGrape).
gusta(belen,elProfesional).
gusta(juan, ironMan).
gusta(pedro, atrapameSiPuedes).
gusta(pedro, rapidoYFurioso).

soloLeGustaPeliculaDeGenero(Persona, Genero):- persona(Persona), generoPelicula(Genero), 
    forall(gusta(Persona, Pelicula), genero(Pelicula, Genero)).

persona(Persona):- gusta(Persona, _).
generoPelicula(Genero):- genero(_, Genero).


peliculasQueLeGustaPorGenero(Persona, Genero, ListaPeliculas):- persona(Persona), 
    generoPelicula(Genero), 
    findall(Pelicula, gustaPeliculaGenero(Persona, Genero, Pelicula), ListaPeliculas).

gustaPeliculaGenero(Persona, Genero, Pelicula):-gusta(Persona, Pelicula), 
    genero(Pelicula, Genero).


%lugar(nombre,hotel(nombre,cantEstrellas,montoDiario)%
lugar(marDelPlata, hotel(elViajante,4,1500)).
lugar(marDelPlata, hotel(casaNostra,3,1000)).
lugar(lasToninas, hotel(holidays,2,500)).
lugar(lasToninas, carpa(60)).
lugar(tandil,quinta(amanecer,pileta,650)).
lugar(bariloche,carpa(80)).
lugar(laFalda, casa(pileta,600)).
lugar(laFalda, carpa(70)).
lugar(rosario, casa(garaje,400)).

%puedeGastar(nombre,cantDias,montoTotal)%
puedeGastar(ana,4,10000).
puedeGastar(hernan,5,8000).
puedeGastar(mario,5,4000).

puedeIr(Persona, Lugar, Alojamiento):-  puedeGastar(Persona, Dias, Disponible),  lugar(Lugar, Alojamiento), 
        cumpleCondiciones(Alojamiento,  MontoDia), Total is MontoDia * Dias, 
            Total =< Disponible.

cumpleCondiciones(hotel(_, Estrellas, MontoDia), MontoDia):- Estrellas > 3.
cumpleCondiciones(casa(garaje, MontoDia), MontoDia).
cumpleCondiciones(quinta(_, pileta, MontoDia), MontoDia).
cumpleCondiciones(carpa(MontoDia), MontoDia).


puedeIrACualquierLugar(Persona):- persona(Persona), 
    forall(lugar(Lugar, _), puedeIr(Persona, Lugar, _)).