%Exercicio: fatorial

predicates
 	 fatorial(integer,integer)

clauses
  	fatorial(0,1):-!.
  	fatorial(X,R):-
  		R = X * R1,
  		X1 = X - 1,
  		fatorial(X1,R).

goal
 	 fatorial(5,Resp),
  	write(Resp).