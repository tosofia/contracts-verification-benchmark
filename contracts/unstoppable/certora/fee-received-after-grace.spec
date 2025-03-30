//https://prover.certora.com/output/245508/4260e0ccefc84dcab41a329094dbc662?anonymousKey=babc25bdd9ad52439e635d8a0dc9373182c9fdd4
methods {
    function _.onFlashLoan(address, address, uint256, uint256, bytes) external => DISPATCHER(true);
}

rule fee_received_after_grace {
    env e;
    uint256 expectedFee;

    address receiver;
    address token;
    uint256 amount;
    bytes data;

    mathint oldFeeRecipientBalance = currentContract.asset.balanceOf(e, currentContract.feeRecipient);
    
    require(currentContract.end <= e.block.timestamp);
    //require(receiver != currentContract.feeRecipient);

    //expectedFee = flashFee(e, token, amount);
    flashLoan@withrevert(e, receiver, token, amount, data);

    //require(oldFeeRecipientBalance + expectedFee <= max_uint);
    //assert(oldFeeRecipientBalance + expectedFee == currentContract.asset.balanceOf(e, currentContract.feeRecipient));
    satisfy(!lastReverted);
}