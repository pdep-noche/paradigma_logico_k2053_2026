
contador(roque).
joven(roque).
trabajoEn(roque,acme).
trabajoEn(juan, acme).
trabajoEn(ana,omni).
trabajoEn(lucia,omni).
trabajoEn(julia, omni).
honesto(roque).
ingeniero(ana).
ingeniero(juan).
habla(roque,frances).
habla(ana,ingles).
habla(ana,frances).
habla(lucia,ingles).
habla(lucia,frances).
habla(cecilia,frances).
abogado(cecilia).
ambicioso(cecilia).
ambicioso(julia).
ambicioso(Persona):- contador(Persona), joven(Persona).
tieneExperiencia(Persona):- trabajoEn(Persona, _).
profesional(Persona):-abogado(Persona).
profesional(Persona):-ingeniero(Persona).
profesional(Persona):-contador(Persona).
puedeAndar(comercioExterior, Persona):-ambicioso(Persona).
puedeAndar(contaduria, Persona):-contador(Persona), honesto(Persona).
puedeAndar(ventas, Persona):-ambicioso(Persona), tieneExperiencia(Persona).
puedeAndar(ventas, lucia).
puedeAndar(proyectos, Persona):-ingeniero(Persona), tieneExperiencia(Persona).
puedeAndar(proyectos, Persona):-abogado(Persona), joven(Persona).
puedeAndar(logistica, Persona):-profesional(Persona), cumpleCondicion(Persona).
cumpleCondicion(Persona):-joven(Persona).
cumpleCondicion(Persona):-trabajoEn(Persona, omni).



madre(mona, homero).
madre(jaqueline, marge).
madre(marge, maggie).
madre(marge, bart).
madre(marge, lisa).
padre(abraham, herbert).
padre(abraham, homero).
padre(clancy, jaqueline).
padre(homero, maggie).
padre(homero, bart).
padre(homero, lisa).

hermano(Persona, OtraPersona):- mismaMadre(Persona, OtraPersona), mismoPadre(Persona, OtraPersona).

mismaMadre(Persona, OtraPersona):- madre(Madre, Persona ), madre(Madre, OtraPersona), Persona \= OtraPersona.
mismoPadre(Persona, OtraPersona):- padre(Padre, Persona), padre(Padre, OtraPersona), Persona \= OtraPersona. 