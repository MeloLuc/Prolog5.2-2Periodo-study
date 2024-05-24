%Exercicio: lista sem repetição

domains
l = integer* 

predicates
  list_sem_rep(l,l,l)
  pertence(integer,l)
  
clauses
  list_sem_rep([],X,X):-!.
  list_sem_rep([X|C],LT,LR):-
  	pertence(X,LT),!,
  	list_sem_rep(C,LT,LR).
  list_sem_rep([X|C],LT,LR):-
  	list_sem_rep(C,[X|LT],LR).
  
  pertence(X,[X|_]):-!.
  pertence(X,[_|Y]):-
  	pertence(X,Y).
  			
goal
  Lista = [1,2,1,2,1,2,3,4,4],
  list_sem_rep(Lista,[],LR),
  write("A lista de entrada era: ", Lista),nl,
  write("A lista sem repetição é: ",LR).