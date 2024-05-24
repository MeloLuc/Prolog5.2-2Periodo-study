%Exercicio: Pergunta nome mostra idade

domains 
listanome = string*
listaidade = integer*

predicates
  res1(listanome,string,integer,integer)
  pega_idade(listaidade,integer,integer)
  
clauses
  pega_idade([Idade|_],0,Idade):- !.
  pega_idade([_|Y],C,Idade):-
  	C1 = C - 1,
  	pega_idade(Y,C1,Idade).  res1([],N,X,X):-!, 
  	write("Não encontrei o nome ",N).
  res1([Nome|_],Nome,X,X):-!.
  res1([_|Y],Nome,C,R):-
   	C1 = C + 1,
   	res1(Y,Nome,C1,R).
   
goal
  ListaNome = ["Saulo","Ana","Paula","Roberta"],
  ListaIdade = [61,17,18,21],
  write("De quem você quer saber a idade: "),readln(Nome),
  res1(ListaNome, Nome,0, Pos),
  pega_idade(ListaIdade,Pos,Idade),
  write("A posição de ",Nome, " na lista ",ListaNome," é ",Pos," e tem ",Idade, "anos").