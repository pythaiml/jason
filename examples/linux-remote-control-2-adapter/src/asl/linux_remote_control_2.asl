+p(X) <-
	.print("YAY!",X).

+!run <-
	// doTest(test);
	get_directory_files('/var/lib/myfrdcsa/collaborative/git/jason',X);
	.print("HEYA:",X).
	
	
!run.

// Should probably have an action that asserts into FreeKBS2 for long
// time storage.  need to finish query/retractall.
