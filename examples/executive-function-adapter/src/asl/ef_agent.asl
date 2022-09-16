
/* see also:

/var/lib/myfrdcsa/codebases/minor/executive-function/frdcsa/sys/flp/autoload/executive_function.pl
/var/lib/myfrdcsa/codebases/minor/executive-function/frdcsa/sys/flp/autoload/executive_function.txt

/var/lib/myfrdcsa/collaborative/git/jason/examples/executive-function-adapter/src/asl/to.do
/var/lib/myfrdcsa/collaborative/git/jason/examples/executive-function-adapter/src/asl/agent2.asl
/var/lib/myfrdcsa/collaborative/git/jason/examples/executive-function-adapter/src/asl/executive_function.asl

/var/lib/myfrdcsa/collaborative/git/jason/examples/executive-function-adapter/jason_executive_function_helper.pl
/var/lib/myfrdcsa/collaborative/git/jason/examples/executive-function-adapter/jason_executive_function_wrapper.pl
*/
	
+!elicit_entry(Agent,Entry,Type) <-
	!flp_ask(['Please state your task/objective: '],Entry);
	.print(classify_entry(Agent,Entry,Type));
	!classify_entry(Agent,Entry,Type);
	.print(add_entry(Agent,Entry,Type));
	!add_entry(Agent,Entry,Type).

+!classify_entry(Agent,Entry,Type) <-
	!flp_ask(['Is it an objective or a task: '],Type);
	.print(type(Type)).

+!add_entry(Agent,Entry,objective) <-
	+hasObjective(Agent,Entry).

+!add_entry(Agent,Entry,task) <-
	+hasTask(Agent,Entry).

+hasObjective(Agent,Objective) : not currentlyObtainableForP(Agent,Objective) & not ~currentlyObtainableForP(Agent,Objective) <-
	!flp_ask(['Is it currently obtainable: '],Answer);
	.print('Answer: ',Answer);
	if (.substring(Answer,'yes')) {
			      .print("Yeha!");
			      +currentlyObtainableForP(Agent,Objective);
			      };
	if (.substring(Answer,'no')) {
				      .print("Boo hoo!");
				      +~currentlyObtainableForP(Agent,Objective);
				      }.

+currentlyObtainableForP(Agent,Objective) <-
	.print('Agent: ',Agent,' has currently obtainable objective: ',Objective);
	.print('Do not necessarily want to break down objective: ',Objective,' into subgoals').

+~currentlyObtainableForP(Agent,Objective) <-
	.print('Agent: ',Agent,' has currently unobtainable objective: ',Objective);
	!get_subgoals_for_objective(Agent,Objective,SubGoals).

+!get_subgoals_for_objective(Agent,Objective,Subgoals) <-
	.print('Researching subgoals to achieve objective');
	!flp_query([hasSubgoal(Objective,_Subgoal)],Subgoals);
	.print('Subgoal: ',Subgoals).

/*  !convert_from_pengine_list_to_jason_list(Subgoals,List);
    for (.member(hasSubgoal(_,Entry),List)) {
    .print('Entry: ',Entry);
    !classify_entry(Agent,Entry,Type);
    }
    .*/

+!get_subtasks_for_task(Agent,Task,Tasks) <-
	.print('hi').
