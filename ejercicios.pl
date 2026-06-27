habla(juan, espaniol).
habla(juan, ingles).
habla(juan, italiano).
habla(marcela, espaniol).
habla(hernan, aleman).

seComunican(Persona, OtraPersona):- habla(Persona, Idioma), 
    habla(OtraPersona, Idioma), Persona \= OtraPersona.

