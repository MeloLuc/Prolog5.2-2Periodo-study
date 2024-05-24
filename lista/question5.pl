domains

l = integer*

predicates

  leia(l,l)
  inverte(l,l,l)
clauses

  leia(LT,LR):-
  	readint(X),
  	X > -1,!,
  	leia([X|LT],LR).
  leia(X,X):-!.	
  
  inverte([],R,R):-!.
  inverte([A|B],LT,R):-
  	inverte(B,[A|LT],R).

goal

leia([],LR),
inverte(LR,[],R),
write(R).