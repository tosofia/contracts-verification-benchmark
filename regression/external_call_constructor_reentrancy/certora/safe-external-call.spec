rule safe_external_call {
	assert(currentContract.x == 0);
}