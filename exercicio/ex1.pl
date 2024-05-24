%Exercicio: par e impar%

domains
	lista = integer*
	lista_lista = lista*

predicates
  	par_impar(lista,lista,lista,lista_lista)

clauses
	par_impar([],Lista1,Lista2,[Lista1,Lista2]):-!.
	
  	par_impar([X|Y],LP,LI,LZ):-
  		0 = X mod 2,
  		par_impar(Y,[X|LP],LI,LZ),!.
  	
  	par_impar([X|Y],LP,LI,LZ):-
  		par_impar(Y,LP,[X|LI],LZ),!.

goal
  	L = [1,2,3,4,5,6,7,8,9,11],
  	par_impar(Lista,[],[],LR),
  	write(LR).