%Exercicio: soma lista de lista

domains
	lista = integer*
	lista_de_lista = lista*

predicates
	somalista(lista,integer,integer)
	gera_lista_de_somas(lista_de_lista,lista,lista)
	inverte(lista,lista,lista)

clauses
	inverte([],X,X):-!.
	inverte([X|Y],T,R):-
		inverte(Y,[X|T],R).
	somalista([],X,X):-!.
	somalista([X|Y],T,R):-
		T1 = T + X,
		somalista(Y,T1,R).
	

	gera_lista_de_somas([],X1,X):-!,
		inverte(X1,[],X).
	gera_lista_de_somas([X|Y],LT,LR):-
		somalista(X,0,Soma),
       	 gera_lista_de_somas(Y,[Soma|LT],LR).

goal
	L = [[1, 4, 2],[7],[],[5,7]],
	gera_lista_de_somas(L,[],LR),
	somalista(LR,0,T),
	write("A lista de saída de gera_lista_de_somas de ",L," é ",LR),nl,
	write("e a soma de todos os elementos da nova lista é ",T).
	