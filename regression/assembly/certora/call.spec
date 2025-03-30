//https://prover.certora.com/output/35919/751a54de2dc14966826b858a4ba9e637?anonymousKey=04c99f536fb5385d8df556a329ef0c7962019214

using DamnValuableToken as token;

methods{
    function _.transfer(address to, uint256 amount) external => DISPATCHER(true);
}

rule call {
    env e;
    address to;
    uint256 amount;
    require(currentContract != to);
    require(token.balanceOf(e, to) + amount < max_uint256);
    require(token.balanceOf(e, currentContract) >= amount);
    uint256 oldBalanceTo = token.balanceOf(e, to);
    uint256 oldBalance = token.balanceOf(e, currentContract);
    bool success = f_wrap(e, token, to, amount);

    assert(oldBalanceTo + amount == token.balanceOf(e, to));
    assert(oldBalance - amount == token.balanceOf(e, currentContract));
}