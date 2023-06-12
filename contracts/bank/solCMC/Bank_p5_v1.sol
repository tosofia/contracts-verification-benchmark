//SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.2;

contract Bank {
    mapping (address => uint) balances;

    receive() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public {
        require(amount > 0);
        require(amount <= balances[msg.sender]);

        balances[msg.sender] -= amount;

        (bool success,) = msg.sender.call{value: amount}("");
        require(success);
    }

    function invariant(uint amount) public {
        require(msg.sender != address(this));
        uint _totalBalanceBefore = address(this).balance;
        withdraw(amount);
        uint _totalBalanceAfter = address(this).balance;
        assert(_totalBalanceBefore >= _totalBalanceAfter);
    }

}
