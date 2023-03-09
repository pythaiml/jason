:- dynamic lrcMessage/1.

flp_query_cyc_user(Question,Answer) :-
	view([flp_query_cyc_user(Question,Answer)]),
	Question = ['',Prolog],
	call(Prolog),
	%% cycQuery(Question,'EverythingPSC',Answer),
	view([answer,Answer]).

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
	atom_concat('as-call ',TmpQueryAtom,QueryAtom),
	view([queryAtom,QueryAtom]),
	atomic_list_concat(['unilang-client -q -r FCMS -c "',QueryAtom,'"'],'',Command),
	shell_command_to_string(Command,Result),
	view([result,Result]),
	%% flp_ask_user(Query,Answer),
	getLrcMessage(Answer).

getLrcMessage(Answer) :-
	repeat,
	findall(Message,lrcMessage(Message),Messages),
	length(Messages,L),
	(   (	L > 0) ->
	    (	view([messages,Messages]),Messages = [Answer|_],retractall(lrcMessage(_)),!) ;
	    (	sleep(1),
		fail)).

%% getLrcMessageNewButNotNecessary(Answer) :-
%% 	repeat,
%% 	findall(Message,lrcMessage(Message),Messages),
%% 	length(Messages,L),
%% 	(   (	L > 0) ->
%% 	    (	view([messages,Messages]),Messages = [Answer|_],retract(lrcMessage(Answer)),!) ;
%% 	    (	sleep(1),
%% 		fail)).

lrc_respond_to_jason(List,Result) :-
	correctLists(List,[username,UserName,message,Message]),
	assertz(lrcMessage(Message)).

hasCannedReplyConcat(Message,Answer) :-
	hasCannedReply(Question,Answer),
	atomic_list_concat(Question,'',Message),
	!.

lrc_respond_to_jason_canned(List,Answer) :-
	correctLists(List,[username,UserName,message,Message]),
	view([lrc_respond_to_jason_canned(Question,Answer)]),
	hasCannedReplyConcat(Message,Answer),
	view([lrc_respond_to_jason_canned_answer,Answer]),
	assertz(lrcMessage(Answer)).