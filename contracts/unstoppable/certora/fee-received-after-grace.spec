//https://prover.certora.com/output/35919/c2d81a8f3b5e4fb997c2e3f8cb287d74?anonymousKey=7232bd291bb49f1f922c4d2496f5ffe5f4225f9d
methods{
    function _.transfer(address, uint256) external => DISPATCHER(true);
    function _.onFlashLoan(address, address, uint256, uint256, bytes) external => DISPATCHER(true);
    function _.approve(address, uint256) external => DISPATCHER(true);
    function _.transferFrom(address, address, uint256) external => DISPATCHER(true);
}
rule fee_received_after_grace {
    env e;
    uint256 expectedFee;

    address receiver;
    uint256 amount;
    bytes data;

    mathint oldFeeRecipientBalance = currentContract.asset.balanceOf(e, currentContract.feeRecipient);
    
    require(currentContract.end <= e.block.timestamp);
    require(receiver != currentContract.feeRecipient);

    expectedFee = flashFee(e, currentContract.asset, amount);
    require(oldFeeRecipientBalance + expectedFee <= max_uint);
    
    flashLoan(e, receiver, currentContract.asset, amount, data);
    
    assert(oldFeeRecipientBalance + expectedFee == currentContract.asset.balanceOf(e, currentContract.feeRecipient));
}