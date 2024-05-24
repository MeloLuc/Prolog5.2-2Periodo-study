domains 


lista = integer*


predicates

a_maior_venda(lista,integer,integer)
pega_prim(lista,integer)
conta(lista,integer,integer,integer)
soma(lista,integer,integer)
conta_todos(lista,integer,integer)

clauses



a_maior_venda([],X,X):-!.
a_maior_venda([X|Y],T,R):-
	X > T,!,
	a_maior_venda(Y,X,R).
a_maior_venda([_|Y],T,R):-
	a_maior_venda(Y,T,R).
		
pega_prim([X|_],X).

conta([],_,X,X):-!.
conta([X|Y],X,T,Quantos):- !,
	T1 = T + 1,
	conta(Y,X,T1,Quantos).
conta([_|Y],X,T,C):-
	conta(Y,X,T,C).

soma([],X,X):-!.
soma([X|Y],T,R):-
	T1= T + X,
	soma(Y,T1,R).		
conta_todos([],X,X):-!.
conta_todos([X|Y],T,Soma):-
	T1 = T + 1,
	conta_todos(Y,T1,Soma).
	
goal


L = [1,2,3,4,5,8,4,5,6,4,5,6,3,7,4,8,2,3,4,5,6],
pega_prim(L,C),
a_maior_venda(L,C,R),
	write("A maior venda foi ",R),nl,
conta(L,R,0,Quantos),
	write("Repetiu: ",Quantos),nl,
soma(L,0,Soma),
	write("A soma = ",Soma),nl,
conta_todos(L,0,Conta_todos),
Media = Soma/Conta_todos,
	write("A média = ", Media),nl.