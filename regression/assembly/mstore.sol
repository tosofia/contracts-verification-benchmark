pragma solidity ^0.8.29;
contract C {
	struct S {
		uint x;
	}

	S s;

	function f() public {
		s.x = 42;
		S memory sm = s;
		uint256 i = 7;
		assembly {
			mstore(sm, i)
		}
        s = sm;
	}
}