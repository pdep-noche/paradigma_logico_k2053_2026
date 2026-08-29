
%jockey(Nombre, Altura, Peso)
jockey(valdivieso,155,52).
jockey(leguisamo,161,49).
jockey(lezcano,149,50).
jockey(baratucci,153,55).
jockey(falero,157,52).

%caballo(nombre).
caballo(botafogo).
caballo(oldMan).
caballo(energica).
caballo(matBoy).
caballo(yatasto).

%preferencia(nombreCaballo, jockey)
preferencia(botafogo, Jockey):- jockey(Jockey, _, Peso), Peso < 52.
preferencia(botafogo, baratucci).
preferencia(oldMan, Jockey):-jockey(Jockey, _, _), atom_length(Jockey, CantLetras), 
    CantLetras > 7.
preferencia(energica, Jockey):-jockey(Jockey, _, _), not(preferencia(botafogo, Jockey)).
preferencia(matBoy, Jockey):-jockey(Jockey, Altura, _), Altura > 170. 

%representa(stub, jockey)
representa(elTute, valdivieso).
representa(elTute, falero).
representa(lasHormigas, lezcano).
representa(elCharabon, baratucci).
representa(elCharabon, leguisamo).

%premio(caballo, premio).
premio(botafogo, granPremioNacional).
premio(botafogo, granPremioRepublica).
premio(oldMan, granPremioRepublica).
premio(oldMan, campeonatoPalermoDeOro).
premio(matBoy, gramPremioCriadores).

%Punto2
prefiereMasDeUno(Caballo):-preferencia(Caballo, Jockey), preferencia(Caballo, OtroJockey), 
            Jockey \= OtroJockey.


%Punto 3
aborrece(Caballo, Stub):-caballo(Caballo), stub(Stub),
        not((representa(Stub, Jockey), preferencia(Caballo, Jockey))).


stub(Stub):-representa(Stub,_).    


%Punto 4

premioImportante(granPremioNacional).
premioImportante(granPremioRepublica).

esPiolin(Jockey):-jockey(Jockey, _, _),
    forall(ganoPremioImportante(Caballo), preferencia(Caballo, Jockey)).

ganoPremioImportante(Caballo):-premio(Caballo, Premio), premioImportante(Premio).


%Punto5
apuestaGanadora(ganador(Caballo), [Caballo|_]).
apuestaGanadora(segundoGanador(Caballo), [Caballo|_]).
apuestaGanadora(segundoGanador(Caballo), [_, Caballo|_]).
apuestaGanadora(exacta(Caballo, OtroCaballo), [Caballo, OtroCaballo|_]).
apuestaGanadora(imperfecta(Caballo, OtroCaballo), [Caballo, OtroCaballo|_]).
apuestaGanadora(imperfecta(Caballo, OtroCaballo), [OtroCaballo, Caballo|_]).


%Punto 6
colorDeCaballo(botafogo, negro).
colorDeCaballo(oldMan, marron).
colorDeCaballo(energica, gris).
colorDeCaballo(energica, negro).
colorDeCaballo(matBoy, marron).
colorDeCaballo(matBoy, blanco).
colorDeCaballo(yatasto, blanco).
colorDeCaballo(yatasto, marron).

puedeComprar(Color, CaballosAComprar):-caballosDisponibles(Color, TodosLosCaballos), 
            subconjunto(TodosLosCaballos, CaballosAComprar), CaballosAComprar \= [].


color(Color):-colorDeCaballo(_, Color).

caballosDisponibles(Color, TodosLosCaballos):- color(Color), 
    findall(Caballo, colorDeCaballo(Caballo, Color), TodosLosCaballos).


subconjunto([], []).
subconjunto([Cab|Cola], [Cab|Resto]):-subconjunto(Cola, Resto).
subconjunto([_|Cola], Lista):- subconjunto(Cola, Lista).