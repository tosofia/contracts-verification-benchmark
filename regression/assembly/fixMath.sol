// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.29;

contract C {
    uint256 internal constant MAX_UINT256 = 2**256 - 1;

    uint256 internal constant WAD = 1e18; // The scalar of ETH and most ERC20s.

    function mul_wrap(uint256 x, uint256 y) external pure returns (uint256) {
        return mulWadDown(x, y);
    }

    function get_wad() external pure returns (uint256) {
        return WAD;
    }

    function mulWadDown(uint256 x, uint256 y) internal pure returns (uint256) {
        return mulDivDown(x, y, WAD); // Equivalent to (x * y) / WAD rounded down.
    }
        
        
    function mulDivDown(
        uint256 x,
        uint256 y,
        uint256 denominator
    ) internal pure returns (uint256 z) {
        /// @solidity memory-safe-assembly
        assembly {
            // Divide x * y by the denominator.
            z := div(mul(x, y), denominator)
        }
    }
}