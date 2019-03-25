%EX 1.
%Sem Cauda.
pa(1,P,_,P):-!.
pa(N,P,R,E):-
    N > 1,
    N1 is N-1,
    Next is P + R,
    pa(N1,Next,R,E).

%Com Cauda.
pa_cauda(1,P,_,P):-!.
pa_cauda(N,P,R,E):-
    N > 1,
    N1 is N-1,
    pa(N1,P,R,E1),
    E is E1 + R.

%EX 2.
%Com Cauda.
soma_pa(1,E,_,E):-!.
soma_pa(N,P,R,S):-
    N > 1,
    pa(N,P,R,E),
    N1 is N-1,
    soma_pa(N1,P,R,S1),
    S is S1 + E.

%Sem Cauda.
soma_pa(N,P,R,S):-
    N > 1,
    pa(N,P,R,E),
    N1 is N-1,
    Next is E + R,
    soma_pa(N1,Next,R,S).

%EX 3.
/*
1. X = a.
2. X = [ ].
3. false.
4. X = [a].
5. false.
6. X = a, Y = b.
7. false.
8. X = a, Y = b, Z = c.
9. false.
10. X = a, Y = b.
11. X = A, Y = [ ].
12. false.
13. X = a, Y = [b, c].
14. X = a, Y = b, Z = [c].
15. X = a, Y = b, Z = [ ].
16. false.
17. X = a, Y = b, Z = [c,d].
18. X = a, Y = b, Z = [a].
19. X = [a], Y = b, Z = [a].
*/

%EX 4.
nesimo(1,E,[E|_]):-!.
nesimo(N,E,[_|T]):-
    N>1,
    N1 is N-1,
    nesimo(N1,E,T).

%EX 5.
num_elementos([],0).
num_elementos([_|T],N):-
    num_elementos(T,N1),
    N is N1 + 1.

%EX 6 e 7.
tira_elem(E,[E|T],T):-!.
tira_elem(E,[H|T],[H|T1]):-
    tira_elem(E,T,T1).

%EXTRA
tira_elem_pos(1,[X|T],X,T).
tira_elem_pos(N,[H|T],X,[H|T2]):-
    N > 1,
    N1 is N-1,
    tira_elem_pos(N1,T,X,T2),!.

%EX 8 e 9.
ret_ocor(_,[],[]).
ret_ocor(E,[E|T],T1):-
    ret_ocor(E,T,T1).
ret_ocor(E,[H|T],[H|T1]):-
    ret_ocor(E,T,T1),!.

%EXTRA.
pertence(E,[E|_]).
pertence(E,[_|T]):-
    pertence(E,T).

%EX 10.
ret_rep([],[]).
ret_rep([H|T],L):-
    pertence(H,T),
    ret_rep(T,L),!.
ret_rep([H|T],[H|T1]):-
    not(pertence(H,T)),
    ret_rep(T,T1).

%EX 11.
concatenar([],L,L).
concatenar([H|T],L,[H|T3]):-
    concatenar(T,L,T3).

%EX 12.
maior([E|[]],E).
maior([H|T],M):-
    maior(T,M1),
    (H > M1 -> M = H; M = M1).

%EX 13.
menor([E|[]],E).
menor([H|T],M):-
    menor(T,M1),
    (H < M1 -> M = H; M = M1),!.

%EX 14.
pegar([],_,[]).
pegar([H|T],L2,L):-
    pegar(T,L2,Laux),
    tira_elem_pos(H,L2,X,_),
    insere_inicio(X,Laux,L).

%EX 15.
insere_inicio(X,L,[X|L]).

%EX 16.
insere_N(E,1,L,[E|L]).
insere_N(E,N,[H|T1],[H|T2]):-
    N > 1,
    N1 is N-1,
    insere_N(E,N1,T1,T2).

%EXTRA.
insere_final(X,[],[X]):-!.
insere_final(X,[H],[H,X]).
insere_final(X,[H|T],[H|T2]):-
    insere_final(X,T,T2),!.

%EX 17.
inverter([],[]).
inverter([H|T],L2):-
    inverter(T,Laux),
    insere_final(H,Laux,L2),!.

%EX 18.
substitui(X,Y,[Y|T],[X|T]).
substitui(X,Y,[H|T],[H|T2]):-
    substitui(X,Y,T,T2),!.

%EX 19.
duplica_todos([],[]).
duplica_todos([H|T],[H,H|T2]):-
    duplica_todos(T,T2).

%EX 20.
duplica(E,[E|T],[E,E|T]).
duplica(E,[H|T],[H|T2]):-
    duplica(E,T,T2),!.

%EX 21.
vazia([],_).
vazia([H|T],L2):-
    vazia(T,L2),
    not(pertence(H,L2)).

nao_vazia(X,Y):- not(vazia(X,Y)).

%EX 22.
uniao([],[],[]).
uniao(L,L2,L3):-
    concatenar(L,L2,L4),
    ret_rep(L4,L3).

%EX 23.
disjuntos(L,L2):-
    vazia(L,L2).

% EX 24.
iguais([],_).
iguais([H|T],L2):-
    iguais(T,L2),
    pertence(H,L2),!.