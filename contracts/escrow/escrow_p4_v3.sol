// SPDX-License-Identifier: GPL-3.0-only
pragma solidity >= 0.8.2;

import "lib/ReentrancyGuard.sol";

contract Escrow is ReentrancyGuard {
    enum Phase {JOIN, CHOOSE, REDEEM, ARBITR, END}

    Phase phase;

    uint fee_rate;      // fee_rate == 20 -> 0.20%

    address buyer;
    address seller;
    address escrow;

    uint deposit;       // buyer's deposit

    address buyer_choice;       // recipient of the deposit
    address seller_choice;      // recipient of the deposit
    address escrow_choice;      // choice of the escrow

    // ghost variable
    address _recipient;

    constructor (
        address escrow_, 
        uint fee_rate_) {

        require(fee_rate_ <= 10000);    // The fee cannot be more than the deposit

        escrow = escrow_;
        fee_rate = fee_rate_;

        phase = Phase.JOIN;
    }

    modifier phaseJoin() {
        require(phase == Phase.JOIN);
        _;
    }
    
    modifier phaseChoice() {
        require(phase == Phase.CHOOSE);
        _;
    }

    modifier phaseRedeem() {
        require(phase == Phase.REDEEM);
        _;
    }

    modifier phaseArbitrate() {
        require(phase == Phase.ARBITR);
        _;
    }

    /*****************
          Join Phase
        *****************/
    function join(address seller_) public payable phaseJoin nonReentrant {

        require(msg.sender != seller_);

        buyer = msg.sender;
        seller = seller_;
        deposit = msg.value;

        phase = Phase.CHOOSE;

    }

    /*****************
         Choice Phase
        *****************/
    function choose(address choice) public phaseChoice nonReentrant {

        if (msg.sender == seller && seller_choice == address(0)) {
            seller_choice = choice;
            if (buyer_choice != address(0)) 
                phase = Phase.REDEEM;
        } else if (msg.sender == buyer && buyer_choice == address(0)) {
            buyer_choice = choice;
            if (seller_choice != address(0)) 
                phase = Phase.REDEEM;
        }
    }

    function refund() public phaseChoice nonReentrant {

        require(msg.sender == buyer);
        require(seller_choice == address(0));

        phase = Phase.END;

        deposit = 0;

        _recipient = buyer;

        (bool success,) = buyer.call{value: deposit}("");      
        require(success);
    }
 
    /*****************
         Redeem Phase 
        *****************/
    
    function redeem() public phaseRedeem nonReentrant {

        require(msg.sender == seller);
        require(buyer_choice == seller_choice);

        phase = Phase.END;

        deposit = 0;

        _recipient = seller_choice;

        (bool success,) = seller_choice.call{value: deposit}("");
        require(success);
    }

    function arbitrate(address escrow_choice_) public phaseRedeem nonReentrant {

        require(msg.sender == escrow);
        require(escrow_choice_ == buyer_choice || escrow_choice_ == seller_choice);
        
        escrow_choice = escrow_choice_;

        phase = Phase.ARBITR;

        _recipient = escrow;

        uint fee = deposit * (fee_rate / 10000);
        deposit -= fee;

        (bool success,) = escrow.call{value: fee}("");
        require(success);
    }

    /*****************
         Arbitrate Phase
        *****************/

    function redeem_arbitrated() public phaseArbitrate nonReentrant {

        require(escrow_choice != address(0));

        phase = Phase.END;

        deposit = 0;

        _recipient = escrow_choice;

        (bool success,) = escrow_choice.call{value: deposit}("");
        require(success);
    }

    function invariant() public view {
        require(_recipient != address(0));
        assert(_recipient == escrow || 
               _recipient == buyer_choice || 
               _recipient == seller_choice || 
               _recipient == buyer);

        assert(!(_recipient == seller_choice && 
                 !(buyer_choice == seller_choice || escrow_choice == seller_choice)));
    }

}

// ====
// SMTEngine: CHC
// Time: 1:51.03
// Target: assert
// ----
// Uncaught exception: Dynamic exception type: std::out_of_range std::exception::what: map::at