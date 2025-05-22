// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/// @notice Reentrancy guard mixin without assembly.
abstract contract ReentrancyGuard {
    /// @dev Unauthorized reentrant call.
    error Reentrancy();

    /// @dev Storage variable to track reentrancy status.
    uint256 private _status;
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    constructor() {
        _status = _NOT_ENTERED;
    }

    /// @dev Guards a function from reentrancy.
    modifier nonReentrant() {
        if (_status == _ENTERED) revert Reentrancy();
        _status = _ENTERED;
        _;
        _status = _NOT_ENTERED;
    }

    /// @dev Guards a view function from read-only reentrancy.
    modifier nonReadReentrant() {
        if (_status == _ENTERED) revert Reentrancy();
        _;
    }
}
