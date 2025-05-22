methods {
    function convertToShares(uint256) external returns (uint256) envfree;
    function totalAssets() external returns (uint256) envfree;
}

invariant shares_eq_assets()
    convertToShares(currentContract.totalSupply) == totalAssets();