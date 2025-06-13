/// @custom:invariant
function invariant(address user, address receiver, uint256 amount) public {
   uint256 oldUserBalance = balanceOf(user);

   uint256 oldSumBalances;
   uint256 ownerBalance = 0;
   uint256 receiverBalance = 0;

   if(msg.sender != owner) {
       ownerBalance = balanceOf(owner);
   }
   if(msg.sender != receiver && owner != receiver) {
       receiverBalance = balanceOf(receiver);
   }
   oldSumBalances = balanceOf(msg.sender) + ownerBalance + receiverBalance;

   require(user != owner && user != receiver && user != msg.sender);
   require(oldSumBalances <= totalSupply);
   transfer(receiver, amount);
   assert(balanceOf(user) == oldUserBalance);

   uint256 newSumBalances;
   ownerBalance = 0;
   receiverBalance = 0;

   if(msg.sender != owner) {
       ownerBalance = balanceOf(owner);
   }
   if(msg.sender != receiver && owner != receiver) {
       receiverBalance = balanceOf(receiver);
   }
   newSumBalances = balanceOf(msg.sender) + ownerBalance + receiverBalance;
   assert(newSumBalances == oldSumBalances);
}
