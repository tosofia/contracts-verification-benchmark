rule P2 {
    env e;
    
    require(getBalance() >= getGoal());
    require(e.block.number > getEndDonate());
    require(e.msg.value == 0);
    
    withdraw@withrevert(e);    

    assert !lastReverted;
}

