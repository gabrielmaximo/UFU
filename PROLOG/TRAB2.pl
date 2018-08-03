menu:-
    repeat,
    write('(1) Especifica evidencia'),nl,
    write('(2) Visualiza evidencia'),nl,
    write('(3) Advinhe'),nl,
    write('(4) Remove respostas'),nl,
    write('(5) Sair'),nl,
    le_atomo(X),
    (X == 5, write('fechando..'), nl,!;
    opcao(X),fail).

opcao(1):-
	nl,
	write('Escolha uma opcao: '),nl,
	write('[1] - Característica que ele possui :'),nl,
	write('[2] - Característica que ele não possui :'),nl,
    le_atomo(X),
    (
        (X < 1 ; X > 2) -> 
        (write('digite apenas uma das opcoes validas!'),nl,opcao(1)) ;
        executaop(X)
    ).

opcao(2):-
	listing(sim),nl,
	listing(nao),nl.

opcao(3):-
	adivinhar.

opcao(4):-
	retractall(sim(_)),
    retractall(nao(_)).

executaop(1):-
	write('Digite uma Evidencia: '),
	nl,
	le_atomo(String),
	assert(sim(String)).

executaop(2):-
	write('Digite uma Evidencia: '),
	nl,
	le_atomo(String),
	assert(nao(String)).

adivinhar:-
	hipotetiza(Animal),
	write('O animal eh: '),
	write(Animal),
	nl.

leop(Op):-
    nl,
    le_atomo(Op),
    verificaresp(Op),!.

leop(Op):-
    nl, write('Digite somente s ou n '),
    leop(Op).

verificaresp('s'):- !.
verificaresp('n'):- !.

inicio :-
    repeat,
    hipotetiza(Animal),
    write('O animal eh: '),
    write(Animal),nl,
    removeRespostas,
    write('Deseja Repetir? s/n : '),
    %read(X),
    le_atomo(X),
    X == n, write('saindo..'),nl,!.
    %get(X),
    %X == 110, write('saindo..'),!.

/* hipoteses a serem testadas*/
hipotetiza(leopardo) :- leopardo, !.
hipotetiza(tigre) :- tigre, !.
hipotetiza(girafa) :- girafa, !.
hipotetiza(zebra) :- zebra, !.
hipotetiza(avestruz) :- avestruz, !.
hipotetiza(pinguim) :- pinguim, !.
hipotetiza(albatroz) :- albatroz, !.
hipotetiza(desconhecido). /* nao diagnosticado */

/* regras de identificação do animal */
leopardo :-
    mamifero,
    carnivoro,
    verifica(tem_manchas_escuras).
tigre :-
    mamifero,
    carnivoro,
    verifica(tem_listras_pretas).
girafa :-
    ungulado,
    verifica(tem_pescoco_grande),
    verifica(tem_pernas_grandes).
zebra :-
    ungulado,
    verifica(tem_listras_pretas).
avestruz :-
    passaro,
    verifica(nao_voa),
    verifica(tem_pescoco_grande).
pinguim :-
    passaro,
    verifica(nao_voa),
    verifica(nada),
    verifica(branco_e_preto).
albatroz :-
    passaro,
    verifica(aparece_em_estoria_de_marinheiro),
    verifica(voa).

/* regras de classificação */

mamifero :-
    verifica(tem_pelo), !.
mamifero :-
    verifica(amamenta).
passaro :-
    verifica(tem_penas), !.
passaro :-
    verifica(voa),
    verifica(poe_ovos).
carnivoro :-
    verifica(come_carne), !.
carnivoro :-
    verifica(tem_dentes_pontiagudos),
    verifica(tem_garras).
ungulado :-
    mamifero,
    verifica(tem_cascos), !.
ungulado :-
    mamifero,
    verifica(rumina).

/* formulando perguntas */
pergunta(Pergunta) :-
    write('O animal tem a seguinte caracteristica: '),
    write(Pergunta),
    write('? '),
    %read(Resposta),
    le_atomo(Resposta),
    %get(Resposta),
    trate(Pergunta,Resposta).

trate(Pergunta,Resposta) :-
    Resposta == s,
    %Resposta == 115,
    assert(sim(Pergunta)),!.

trate(Pergunta,Resposta) :-
    (
            Resposta \= n -> (write('Porfavor, digite apenas s ou n..'),nl,pergunta(Pergunta)) ;
        (assert(nao(Pergunta)),fail)
            %Resposta == 110 -> (assert(nao(Pergunta)),fail) ;
        %(write('Porfavor, digite apenas s ou n..'),nl,pergunta(Pergunta))
    ).

:-dynamic 
    sim/1, 
    nao/1.

/* verificando */
verifica(S) :- sim(S),!.
verifica(S) :- nao(S),!, fail.
verifica(S) :- pergunta(S).

/* remove todas as assercoes de sim e nao */

%removeRespostas :- retract(sim(_)), false.
%removeRespostas :- retract(nao(_)), false.

%removeRespostas :- abolish(sim/1), abolish(nao/1),dynamic(sim/1),dynamic(nao/1).

removeRespostas :- 
    retractall(sim(_)),
    retractall(nao(_)).

le_atomo(A):-
    le_str(String),
    name(A,String).

le_str(String):-
    get0(Char),
    le_str_aux(Char,String).

le_str_aux(-1,[]):-!.
le_str_aux(10,[]):-!.
le_str_aux(13,[]):-!.
le_str_aux(Char,[Char|Resto]):-
    le_str(Resto).