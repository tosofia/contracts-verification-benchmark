/// @custom:invariant
function invariant(address receiver, uint256 amount) public {
    uint256 balancesSum;
    uint256 ownerBalance = 0;
    uint256 receiverBalance = 0;

    if(msg.sender != owner) {
        ownerBalance = balanceOf(owner);
    }
    if(msg.sender != receiver && owner != receiver) {
        receiverBalance = balanceOf(receiver);
    }
    balancesSum = balanceOf(msg.sender) + ownerBalance + receiverBalance;

    require(balancesSum <= totalSupply);
    require(amount <= balanceOf(msg.sender) && amount > 0);
    bool isMoneyTransferred = transfer(receiver, amount);
    assert(isMoneyTransferred);
}
