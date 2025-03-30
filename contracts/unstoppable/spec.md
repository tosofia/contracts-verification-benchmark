The contract implements the **`IERC3156FlashLender`** interface, which allows to offer flash loans. The vault is implemented using the standard **`ERC4626`**  interface, which is an extension of **`ERC20`**. 

It implements different functions from **`IERC3156FlashLender`**  and **`ERC4626`:**

- **`maxFlashLoan`**: returns the maximum amount of tokens allowed to be borrowed in a flash loan
- **`flashFee`**: returns the flash loan fee
- **`totalAssets`**: returns the total amount of tokens held by the contract
- **`flashLoan`**: offers a flash loan and executes the callback function of the receiver
There are 4 requirements:
    1. flash loan `amount` should not be equal to 0
    2. the asked `token` should be the same of 
    3. it enforces `ERC4626` requirement by which the `totalSupply` of vault tokens should match the `totalAssets` of DVT tokens
    4. `receiver.onFlashLoan` must return `keccak256("IERC3156FlashBorrower.onFlashLoan")`
    
    After checking the first three requirements, it transfers tokens to receiver, it calls `receiver.onFlashLoan` and then it repays the tokens and sends the flash loan fee to `feeRecipient`.