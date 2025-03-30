//https://prover.certora.com/output/35919/65d0b8734c3e4bb796d5d52289eb1524?anonymousKey=0d35a98c4b3801dc7b9220a02a2efab85d94749f

rule positive_fee_after_grace {
    env e;
    uint256 fee;
    address token;
    uint256 amount;

    require(currentContract.end <= e.block.timestamp);
    require(amount > 0);
    fee = flashFee(e, token, amount);
    assert(fee > 0);
}