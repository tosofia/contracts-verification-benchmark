methods {
    //function C.safe(address token, address to, uint256 amount) internal;
}

rule safe {
    env e;
    address token;
    address to;
    uint256 amount;
    require(e.msg.value == 0);
    require(e.msg.sender != 0);
    
    safe_wrapper@withrevert(e, token, to, amount);
    
    assert(!lastReverted);
}