domains
lista = integer*
ll = lista*
predicates

  buscar_producaodiaDados(ll,lista,integer,integer,integer)
  buscar_producaodia(ll, integer, integer, integer, integer, lista, integer, ll ,ll)
  buscar_producaodiaParte(lista,integer,integer, integer, integer, integer, ll, ll)
  trasnformar(lista,integer)
  soma_producao(lista,integer,integer)
  inverte(lista,lista,lista)
  sequencia_maquina(ll,integer,integer,integer,integer,integer,lista,lista)
  criar_ll(lista,ll,ll)
  
  media_producao(lista,lista,lista,integer)
  maior_producao(lista, integer, integer, integer, integer,integer)
  
  maior_producao_horario(ll,integer,integer,integer,lista)
  sequencia_maquina_horario(ll,integer,integer,integer,integer,integer,lista)
  lista_maquina_dia(ll,integer,integer,integer,integer,integer,lista,lista)
  buscar_maquina(lista,integer,integer,integer,integer,integer,integer)
  
  producao_mhh(ll,integer,integer,integer,integer,lista,lista)

clauses

%============================================== Questão 1 - A ==========================================%

  buscar_producaodiaDados(L,ListaTproducao,D,M,A):-								     %Retornar uma lista já na ordem de máquinas.
  	N = 1,
  	sequencia_maquina(L,N, D, M, A,26,[],ListaTproducaoinvertida),					    %chamo "sequencia_maquina" com condição de parada, maq = 26.
  	inverte(ListaTproducaoinvertida,[], ListaTproducao).
 	
  	
  		
 		
  sequencia_maquina(_,N, _, _, _, N,Lf,Lf):-!.								    %Se o N°|maq for = a condição de parada(26), igualu as listas.
  sequencia_maquina(L,N, D, M, A, Tm,Lt,Lf):-
  	buscar_producaodia(L, N, D, M, A, [], PT, [], Lr),						    %L= lista de lista, PT= produção total do dia de uma máquina,
 		write("MAQUINA:",N,"     DATA:",D,"/",M,"/",A,"     PRODUÇÃO:",PT),nl,			    %Lr = Lista de listas que "não são da maquina 1..."
 	Nl = N + 1,											    
 	sequencia_maquina(Lr,Nl, D, M, A,Tm,[PT|Lt],Lf).						    %Puxo Lr para verificar( diminuiu a lista de lista).

 	
  
  
  buscar_producaodia([], _, _, _, _, P, Pr, Lr, Lr):-!,                                                     % P aqui é uma lista com todas produçoes por hora do dia, somo eles e relaciono Pr como o resultado.
  	soma_producao(P,0,Pr).						             	                    % Verifica se os parametros sao iguais, da o resultado da producao e uma lista com o resto da lista com número e maquina diferente.
  buscar_producaodia([L1|R], N, D, M, A, Pt, PTres, Lt, Lr):-
  	buscar_producaodiaParte(L1, N, D, M, A, P, Lt, Lres),						    
  	buscar_producaodia(R, N, D, M, A,[P|Pt], PTres, Lres, Lr).
  	
  	
  buscar_producaodiaParte([N ,D, M, A, 24|_], N, D, M, A, 0, Lres, Lres):-!.	 %NÃO DEVE APARECER 24<= X OU 0> X NO BANCO DE DADOS, AQUI EU SÓ COLOCO POR PREPAUÇÃO POR 24 SER  COMUM. 
  buscar_producaodiaParte([N ,D, M, A, 0|_], N, D, M, A, 0, Lres, Lres):-!.	 %NÃO DEVO SOMAR ELEMENTOS COM O TEMPO= 0, POIS É A PORDUÇÃO DO DIA ANTERIOR, A PRODUÇÃO DE 0 ESTÁ EM 1
  buscar_producaodiaParte([N ,D, M, A, _|P], N, D, M, A, RL, Lres, Lres):-!,				    %"Se na lista o numero,dia,mes,ano condizer com o que eu pedir rodo o codigo"- P sai 
  	trasnformar(P,R),										    %P sai como lista [P], dai eu puxo"trasformar" que pega a cabeça de P = R e relaciono R com Rl(inteiro)
  	R = RL.												    %Lres não muda pois essa lista pertence a minha condição e não preciso adicionar ela a lista diminuida
  buscar_producaodiaParte(Ll, _, _, _, _, 0, Lt, Lres):-!,							
  	criar_ll(Ll,Lt,Lres).										    %Se L1 não pe do dia,mes... que eu quero, então retorno produção= 0(para não somar)e adiciono L1 a lista diminuida
  													    % criei "criar_ll" para jogar Ll dentro de Lt e relaciono com Lres

   
  
   criar_ll([],Lres,Lres):-!.	
  criar_ll(Ll,Lt,Lres):-
  	criar_ll([],[Ll|Lt],Lres).	
  
  inverte([],R,R):-!.
  inverte([A|B],T,R):-											    %Pequenas clausulas que são puxadas dentro das clausulas principais.
  	inverte(B,[A|T],R).
  	
  soma_producao([],R,R):-!.
  soma_producao([A|B],T,R):-
  	Tl = A + T,
  	soma_producao(B,Tl,R).
  	
  trasnformar([A|_],R):-
  	A = R.
  	
  	
  	
  	
%============================================== Questão 1 - B ==========================================% 
  
  media_producao([],LT, LM, _):-!,
  	inverte(LT,[],LM).
  media_producao([A|B],LT, LM, N):-
  	Media = A / 24,
  	write("MÉDIA DA MAQUINA ",N,":         ",Media),nl,
  	Nl = N + 1,
  	media_producao(B, [Media|LT], LM, Nl).								   %Media está em REAL e o domínio de lista é INTEGER, dai ele arredonda para transformar em inteiro								
  	
  	
  	
  	
 
%============================================== Questão 1 - C ==========================================% 
 
  maior_producao([], 0, _, 0, _, 0):-!,
  	write("                                  *SEM-PRODUÇÃO*"),nl.
  maior_producao([], MP, _, MP, NMPf, NMPf):-!.	 	
  maior_producao([A|B], M, N, MP, _, NMPf):-
  	A >= M,!,
  	Ml = A,
  	NM = N,
  	Nl = N + 1,
  	maior_producao(B, Ml, Nl,MP,NM,NMPf).
  maior_producao([_|B], M, N, MP, NMP, NMPf):-
  	Nl = N +1,
  	maior_producao(B, M, Nl, MP, NMP, NMPf).	





%============================================== Questão 1 - D ==========================================%


  maior_producao_horario(L,D,M,A,Ldiaordenada):-
  write("=================================================================================="),nl,
  	write("Escreva o horário que você deseja saber qual máquina teve maior produção nesse horário(0-23): "),readint(Hl),nl,     %EU digito a hora dentro do intervalo 1-24 e o programa armazena 0-23
  	N = 1,
  	H = Hl +1,                                                                                                                 %Pois a "produção é da hora passada",Logo se eu quero saber a produção da hora 1 tenho que procurar produçaõ na hora 0
  	sequencia_maquina_horario(L,N, D, M, A,H,Ldiaordenada),
  	maior_producao(Ldiaordenada, 0, 1,Maiorproducao, 0, Nmaiorproducao),							    %chamando clausula de outro exercício
  	write("A MÁQUINA QUE MAIS PRODUZIU NESSA HORA FOI:    Máquina ",Nmaiorproducao,"     Produção:",Maiorproducao),nl,			
  	write("=================================================================================="),nl.
  	
  	
		
  sequencia_maquina_horario(L,N, D, M, A, H,Ldiaordenada):-								    
  	lista_maquina_dia(L,N,D,M,A,H,[],Ldia),
  	inverte(Ldia,[],Ldiaordenada).
  
  													     
 							   	
  	
  lista_maquina_dia([],_,_,_,_,_,Lr,Lr):-!.	
  lista_maquina_dia([Ll|B],N,D,M,A,H,Ldt,Lr):-
  	buscar_maquina(Ll,N,D,M,A,H,RL),!,											    %praticamente a mesma lógica da questão A, porém não consegui reutilizar código.
  	Nl = N + 1,
  	lista_maquina_dia(B,Nl,D,M,A,H,[RL|Ldt],Lr).
  lista_maquina_dia([_|B],N,D,M,A,H,Ldt,Lr):-	
  	lista_maquina_dia(B,N,D,M,A,H,Ldt,Lr).
  	
  	
  	
  buscar_maquina([N ,D, M, A, H|P], N, D, M, A, H, RL):-!,				     
  	trasnformar(P,R),										    
  	R = RL.
  buscar_maquina(_,_,_,_,_,_,_):-
  	fail.											   	
  	
  	
  	 
%============================================== Questão 1 - E ==========================================% 	
  	
  producao_mhh(_,_,_,_,24,Lf,Lf):-!.	
  producao_mhh(L,D,M,A,H,Lt,Lf):-	
  	N = 1,
  	sequencia_maquina_horario(L,N, D, M, A, H,Ldiaordenada),                                         %Ldiaordenada guarda os valores da produção de todas as maquinas na hora definida (lista)
  	soma_producao(Ldiaordenada,0,S),
	Horareal = H - 1,
	Media = S/25,
  	write("A MÉDIA DE PRODUÇÃO POR HORA:     HORA:",Horareal,"     Média:",Media),nl,
  	Hl = H + 1,
  	producao_mhh(L,D,M,A,Hl,[Media|Lt],Lf).
  	
  	
  	
  	
  	
 
goal

 
  Dados = [[1,1,2,2023,24,9999999],[1,1,2,2023,1,6002],[1,1,2,2023,2,32],[1,1,2,2023,3,62],[1,1,2,2023,4,300],[1,1,2,2023,5,62],[1,1,2,2023,6,132],[1,1,2,2023,7,623],
           [1,1,2,2023,8,96],[1,1,2,2023,9,632],[1,1,2,2023,10,32],[1,1,2,2023,11,62],[1,1,2,2023,12,300],[2,1,2,2023,0,032],[2,1,2,2023,1,62],[2,1,2,2023,2,132],
           [2,1,2,2023,3,62],[2,1,2,2023,4,3090],[2,1,2,2023,5,62],[2,1,2,2023,6,132],[2,1,2,2023,7,623],[2,1,2,2023,8,96],[2,1,2,2023,9,632],[2,1,2,2023,10,32],
           [2,1,2,2023,11,62],[2,1,2,2023,12,300],[3,1,2,2023,0,1],[3,1,2,2023,1,0],[3,1,2,2023,2,0],[3,1,2,2023,3,0],[3,1,2,2023,4,0],[3,1,2,2023,5,0],[3,1,2,2023,6,0],
           [3,1,2,2023,7,0],[3,1,2,2023,8,0],[3,1,2,2023,9,0],[3,1,2,2023,10,0],[3,1,2,2023,11,0],[3,1,2,2023,12,0], [1,1,3,2023,0,10000],[1,1,2,2024,1,10000],[2,1,2,2023,2,1000],
           [4,1,2,2023,0,10000],[5,1,2,2023,1,10000],[6,1,2,2023,2,1000],[7,1,2,2023,0,100500],[8,1,2,2023,1,10600],[9,1,2,2023,2,10900],[10,1,2,2023,1,1800],[11,1,2,2023,2,100],
           [23,1,2,2023,0,109500],[24,1,2,2023,1,10600],[25,1,2,2023,2,10900],[1,1,2,2023,23,55555]],
  
  %As horas que devem ter produção são de 1-23, no intervalo 0-23 (0 = outro dia).
  
  
  
  write("Qual dia você deseja saber a produção das máquinas (dd/mm/aa)(1/2/2023):"),nl,                %Leitura dos dados.
  write("dd:"),readint(D),
  write("mm:"),readint(M),
  write("aa:"),readint(A),
  write("========================================="),nl,
  
   
   
   
   
  % TOTAL PRODUZINDO POR MÁQUINA POR DIA INFORME O DIA NO RELATÓRIO ==== Questão A
  buscar_producaodiaDados(Dados,ListaTproducao,D,M,A),nl,
  %write("TOTAL DE PRODUÇÃO/DIA EM LISTA: ", ListaTproducao),nl,nl,
  write("========================================="),nl,
  
  
  
  % MEDIA DE PRODUÇÃO POR MÁQUINA(NO DIA QUE ESCOLHI)==== Questão B
  media_producao(ListaTproducao,[], ListaMproducao,1),nl,
  %write("MEDIA DE CADA MÁQUINA EM LISTA(valor arredondado): ", ListaMproducao),nl,nl,
  write("=================================================================================="),nl,
  
  
  
  %QUAL FOI A MÁQUINA QUE MAIS PRODUZIU(NO DIA)==== Questão C
  maior_producao(ListaTproducao, 0, 1,Maiorproducao, 0, Nmaiorproducao),nl,
  write("A MÁQUINA QUE MAIS PRODUZIU NESSE DIA FOI:    Máquina ",Nmaiorproducao,"     Produção:",Maiorproducao),nl,nl,
  
   
  
  %DADO UM HORÁRIO QUAL MÁQUINA TEVE MAIOR PRODUÇÃO NESSE HORÁRIO==== Questão D
  maior_producao_horario(Dados,D,M,A,R),nl,nl,
  
  
  %QUAL FOI A PRODUÇÃO MÉDIA HORA A HORA==== Questão E
  
  producao_mhh(Dados,D,M,A,1,[],ListaMhh),nl,
  write("=================================================================================="),nl.
  