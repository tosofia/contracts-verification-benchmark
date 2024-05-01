methods {
    function getX() external returns (uint) envfree;
}

rule f_reentrancy_view_x {
	env e; 
	calldataarg args;
	mathint x_before = getX();
	f(e, args);
	mathint x_after = getX();
	assert(x_before == x_after);
}