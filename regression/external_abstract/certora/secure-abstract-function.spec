methods {
    function getX() external returns (uint) envfree;
}

rule secure_abstract_function {
	env e;
	mathint x_before = currentContract.x;
	g(e);
	mathint x_after = currentContract.x;
	assert(x_before == x_after);
}