// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.29;

contract C {
	function f(address a, address to) internal returns (bool _success) {
		assembly { 
            let freeMemoryPointer := mload(0x40)
            mstore(freeMemoryPointer, 0x095ea7b300000000000000000000000000000000000000000000000000000000)
            mstore(add(freeMemoryPointer, 4), and(to, 0xffffffffffffffffffffffffffffffffffffffff))
            mstore(add(freeMemoryPointer, 36), 0) 

            _success := and(
                or(and(eq(mload(0), 1), gt(returndatasize(), 31)), iszero(returndatasize())),
                call(gas(), a, 0, freeMemoryPointer, 68, 0, 32)
            )
        }
        require(_success); 
	}

    function f_wrap(address a, address to) external returns(bool){
        return f(a, to);
    }
}