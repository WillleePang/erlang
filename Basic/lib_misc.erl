-module(lib_misc).
-export([for/3,qsort/1,pythag/1,perms/1,filter/2,odds_and_evens/1,odds_and_evens_acc/1,odds_and_evens_acc/3]).
-import(lists,[reverse/1]).

for(Max,Max,F) -> [F(Max)];
for(I,Max,F) -> [F(I)|for(I+1,Max,F)].

qsort([])->[];
qsrot([Pivot|T])->
	qsort(X||X<-T,X<Pivot])
	++[Pivot]++
	qsort(X||X<-T,X>=Pivot]).

pythag(N)->
	[{A,B,C}||
	 	A<-lists:seq(1,N),
		B<-lists:seq(1,N),
		C<-lists:seq(1,N),
		A+B+C=<N,
		A*A+B*B=:=C*C
	].

perms([])->[[]];
perms([H|T]||H<-L,T<-perms(L--[H])].

filter(P,[H|T])->
	case P(H) of
		true->[H|filter(P,T)]
		false->filter(P,T)
	end;
filter(P,[])->
	[].

odds_and_evens(L)->
	Odds = [X||X<-L,(X rem 2)=:=1],
	Evens = [X||X<-L,(X rem 2)=:=0],
	{Odds,Evens}.

odds_and_evens_acc(L)->
	odds_and_evens_acc(L,[],[]).

odds_and_evens_acc([H|T],Odds,Evens)->
	case (H rem 2) of
		1->odds_and_evens_acc(T,[H|Odds],Evens);
		2->odds_and_evens_acc(T,Odds,[H|Evens])
	end;
odds_and_evens_acc([],Odds,Evens)->
	{lists:reverse(Odds),lists:reverse(Evens)}.

sqrt(X) when X < 0 ->
	erlang:error({squareRootNegativeArgument, -1});
sqrt(X) ->
	math:sqrt(X).

sleep(T) ->
	receive
	after T ->
		true
	end.

flush_buffer(T) ->
	receive
		_Any ->
			flush_buffer()
	after 0 ->
		true
	end.

priority_receive() ->
	receive
		{alarm,X} ->
			{alarm,X}
	after 0 ->
		
	end.

on_exit(Pid,Fun) ->
	spawn(fun() - >
		process_flag(trap_exit,true),
		link(Pid),
		receive
			{'EXIT',Pid,Why} ->
				Fun(Why)
		end
	end).