    
rule math {
    env e;
    uint256 x;
    uint256 y;
    require(e.msg.value == 0);
    require(e.msg.sender != 0);

    require x == 2;
    require y == 2;
    
    uint256 r = mul_wrap(e, x, y);
    

    assert(r == 1);
}