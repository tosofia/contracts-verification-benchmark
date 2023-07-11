// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.18;

contract Lottery {
    address[] private players;
    uint private start;
    uint private duration;

    // ghost variables
    bool _picked;
    uint _prev_length;

    constructor(uint duration_) {
        start = block.number;
        duration = duration_;
    }

    function enter() external payable {
        require(msg.value == .01 ether);

        _prev_length = players.length;
        players.push(msg.sender);
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encode(block.prevrandao)));
    }

    function pickWinner() external {
        require(block.number >= start + duration);

        address winner = players[random() % players.length];

        _prev_length = players.length;
        players = new address[](0);

        uint fee = address(this).balance / 100;

        start = block.number;

        _picked = true;

        (bool success,) = msg.sender.call{value: fee}("");
        require(success);

        (success,) = winner.call{value: address(this).balance}("");
        require(success);
    }

    function invariant() public view {
        require(!_picked);
        assert(players.length >= _prev_length);
    }

}
