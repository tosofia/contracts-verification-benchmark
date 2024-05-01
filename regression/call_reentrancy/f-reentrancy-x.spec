rule f_reentrancy_x {
	env e; 
	calldataarg args;
	f(e, args);
	assert(currentContract.x == 0);
}