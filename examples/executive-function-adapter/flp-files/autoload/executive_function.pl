:- dynamic efaMessage/1.

flp_ask_user(Question,Answer) :-
	view([flp_ask_user(Question,Answer)]),
	hasCannedReply(Question,Answer),
	view([answer,Answer]).
	%% sleep(1).

flp_query_flp(Query,Response) :-
	view([flp_query_flp(Query,Response)]),
	findall(Query,call(Query),Response),
	view([responses,Response]).

flp_ask_ws_user(Query,Answer) :-
	correctLists(Query,QueryCorrected),
	view([flp_ask_ws_user(QueryCorrected,Response)]),
	atomic_list_concat(Query,'',TmpQueryAtom),
	atom_concat('call ',TmpQueryAtom,QueryAtom),
	view([queryAtom,QueryAtom]),
	atomic_list_concat(['unilang-client -q -r FCMS -c "',QueryAtom,'"'],'',Command),
	shell_command_to_string(Command,Result),
	view([result,Result]),
	%% flp_ask_user(Query,Answer),
	getEfaMessage(Answer).


efaMessage('Finish executive function system').

getEfaMessage(Answer) :-
	repeat,
	findall(Message,efaMessage(Message),Messages),
	length(Messages,L),
	(   (	L > 0) ->
	    (	Messages = [Answer|_],retractall(efaMessage(_)),!) ;
	    (	sleep(1),
		fail)).

efa_respond_to_jason(List,Result) :-
	correctLists(List,[username,UserName,message,Message]),
	assertz(efaMessage(Message)).

