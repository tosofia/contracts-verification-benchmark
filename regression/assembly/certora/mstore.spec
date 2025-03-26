rule mstore {
    env e;
    f(e);
    assert(currentContract.s.x == 7);
}