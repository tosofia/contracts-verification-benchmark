// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.25;

import "./ERC20.sol";
contract C {
	function f(ERC20 a, address to, uint256 amount) internal returns (bool _success) {
		assembly { 
            let freeMemoryPointer := mload(0x40)
            mstore(freeMemoryPointer, 0xa9059cbb00000000000000000000000000000000000000000000000000000000)
            mstore(add(freeMemoryPointer, 4), and(to, 0xffffffffffffffffffffffffffffffffffffffff))
            mstore(add(freeMemoryPointer, 36), amount) 

            _success := and(
                or(and(1, gt(returndatasize(), 31)), iszero(returndatasize())),
                call(gas(), a, 0, freeMemoryPointer, 68, 0, 32)
            )
        }
        require(_success); 
	}

    function f_wrap(ERC20 token, address to, uint256 amount) external returns(bool){
        return f(token, to, amount);
    }
}