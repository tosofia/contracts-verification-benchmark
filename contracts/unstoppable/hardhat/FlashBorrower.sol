// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./IERC3156FlashBorrower.sol";
import "./IERC3156FlashLender.sol";

/**
 * @title FlashBorrower
 * @author kazunetakeda25
 */
contract FlashBorrower is IERC3156FlashBorrower {
    enum Action {
        NOTHING
    }

    IERC3156FlashLender lender;

    uint256 public flashBalance;
    address public flashInitiator;
    address public flashToken;
    uint256 public flashAmount;
    uint256 public flashFee;

    constructor(IERC3156FlashLender lender_) {
        lender = lender_;
    }

    /// @dev ERC-3156 Flash loan callback
    function onFlashLoan(
        address initiator,
        address token,
        uint256 amount,
        uint256 fee,
        bytes calldata data
    ) external pure override returns (bytes32) {
        return keccak256("IERC3156FlashBorrower.onFlashLoan");
    }
}