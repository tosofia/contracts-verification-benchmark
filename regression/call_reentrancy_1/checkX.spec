rule checkX {
	method fun; 
	env e; 
	calldataarg args;
	fun(e, args);
	assert(currentContract.x == 0);
}