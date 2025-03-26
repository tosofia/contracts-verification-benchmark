// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.29;

contract C {
	function f() internal pure returns (bool) {
		bool b;
		assembly { b := 1 } // This assignment is overapproximated at the moment, we don't know value of b after the assembly block
		return b;
	}
	function g() public pure {
		assert(f()); // False positive currently
		assert(!f()); // should fail, now because of overapproximation in the analysis
		require(f()); // BMC constant value not detected at the moment
		require(!f()); // BMC constant value not ddetected at the moment
	}
}