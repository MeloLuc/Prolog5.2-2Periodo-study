domains 
 
 l =integer*
 
predicates

pertence(l,integer)
sem_rep(l,l,l)
inicializa(l,l)  
inverte(l,l,l)

posicao(integer,integer,l,integer,integer)

nondeterm excluir(l,integer,l,l)
clauses

inverte([],X,X):-!.
inverte([X|Y],LT,LR):-
	inverte(Y,[X|LT],LR).
	
pertence([X|_],X):-!.
pertence([_|Y],N):-
	pertence(Y,N).

sem_rep([],X1,X):-!,
   inverte(X1,[],X).
sem_rep([X|Y],LT,LR):-				%LT é a cabeça
	pertence(LT,X),!,
	sem_rep(Y,LT,LR).
sem_rep([X|Y],LT,LR):-
	sem_rep(Y,[X|LT],LR).

inicializa([X|_],[X]).				%adiciono valor a LT


posicao(_,_,[],-1,-1):-!,                       %Retorna o valor da posição escolhida (-1 inexistente)
	write("POSIÇÃO INEXISTENTE"),nl.	
posicao(P,P,[A|_],_,A):-!,
	write("Posição ", P," da LISTA DE ENTRADA é = ",A).
posicao(P,A,[_|C],Rt,R):-
	Al = A + 1,
	posicao(P,Al,C,Rt,R).

excluir([],_,Lt,Lf):-!,
	inverte(Lt,[],Lf).
excluir([N|B],N,Lt,Lf):-
	excluir(B,N,Lt,Lf).
excluir([A|B],N,Lt,Lf):-
	excluir(B,N,[A|Lt],Lf).
	

	
goal

Lista = [1,2,1,2,3,4,3,5,1,6,2],
write("LISTA DE ENTRADA: ",Lista),nl,nl,
inicializa(Lista,LT),				% LT é a cabeça da Lista
sem_rep(Lista,LT,LR),
write("LISTA SEM DUPLICAÇÃO: ",LR),nl,nl,
write("Digite um posição: "),readint(P),nl,
posicao(P,0,Lista,-1,R),nl,nl,			%NÃO UTILIZO O R, MAS POSSO PRECISAR FUTURAMENTE POR ISSO RETORNO ELE MESMO ASSIM
write("Digite o número que você deseja excluir da LISTA DE ENTRADA: "),readint(N),nl,
excluir(Lista,N,[],Lexcluir),
write("LISTA COM ELEMENTO ",N," EXCLUIDO: ",Lexcluir).