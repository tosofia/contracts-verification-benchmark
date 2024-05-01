rule call_revert {
    env e;
    calldataarg args;
   
    f@withrevert(e, args);
    assert(lastReverted);
}