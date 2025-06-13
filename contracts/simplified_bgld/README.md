# Simplified Deflationary Token

## Specification
This contract implements a simplified version of a deflationary token using `uint256`, where each transaction is charged a fixed fee (10% from the amount of tokens sent).
The contract deployer will get ownership and total token amount and he’ll be excluded from paying transaction fees moreover can decide whether to exclude or include any user from paying them.

## Properties
- **liquidity**: Senders with a positive amount of tokens can always send the amount minus the fee.
- **owner-can-exclude-include-from-fee**: Owner can include or exclude everyone in the fee payment.
- **owner-fee-after-transfer**: To respect the deflationary token property, after every transfer the owner balance must be increased by fees.
- **ownership-cannot-change**: The initial owner of the contract defined during the constructor call, cannot change.
- **total-supply-integrity**: After a transfer, the total amount of tokens is always the same.
- **user-cannot-exclude-include-from-fee**: A generic user cannot include or exclude someone in fees payment.
- **validate-transfer-diff-o-s-r**: If owner, sender and receiver have distinct addresses, their balances are updated correctly after the transfer of a positive amount of tokens: Owner balance is incremented by the fee, Sender balance is decremented by the amount and Receiver balance is incremented by the amount minus the fee.
- **validate-transfer-same-o-r**: If only owner and receiver have the same address, we check that their balances are updated correctly after the transfer of a positive amount of token: Owner balance is incremented by the amount, Sender balance is decremented by the amount and Receiver balance is the same as the owner balance.
- **validate-transfer-same-o-s**: If only owner and sender have the same address, we check that their balances are updated correctly after the transfer of a positive amount of token: Owner balance is decremented by the amount minus the fee, Sender balance is the same as the owner balance and Receiver balance is incremented by the amount minus the fee.
- **validate-transfer-same-o-s-r**: If the owner, sender and receiver have the same address, their balances remain unchanged after the transfer of a positive amount of token.
- **validate-transfer-same-s-r**: If only sender and receiver have the same address, we check that their balances are updated correctly after the transfer of a positive amount of token: Owner balance is incremented by the fee, Sender balance is decremented by the fee and Receiver balance is the same as the sender balance.

## Versions
- **v1**: the transfer amount and fees are wrongly managed, the fees are not deducted from the sender but at the same time the owner receives the right fee amount (token duplication).

## Ground truth
|        | liquidity                            | owner-can-exclude-include-from-fee   | owner-fee-after-transfer             | ownership-cannot-change              | total-supply-integrity               | user-cannot-exclude-include-from-fee | validate-transfer-diff-o-s-r         | validate-transfer-same-o-r           | validate-transfer-same-o-s           | validate-transfer-same-o-s-r         | validate-transfer-same-s-r           |
|--------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|
| **v1** | 0                                    | 1                                    | 0                                    | 1                                    | 0                                    | 1                                    | 0                                    | 0                                    | 0                                    | 0                                    | 0                                    |
 

## Experiments
### SolCMC
#### Z3
|        | liquidity                            | owner-can-exclude-include-from-fee   | owner-fee-after-transfer             | ownership-cannot-change              | total-supply-integrity               | user-cannot-exclude-include-from-fee | validate-transfer-diff-o-s-r         | validate-transfer-same-o-r           | validate-transfer-same-o-s           | validate-transfer-same-o-s-r         | validate-transfer-same-s-r           |
|--------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|
| **v1** | FP!                                  | TP!                                  | TN!                                  | ND                                   | UNK                                  | TP!                                  | UNK                                  | UNK                                  | UNK                                  | UNK                                  | UNK                                  |
 

#### Eldarica
|        | liquidity                            | owner-can-exclude-include-from-fee   | owner-fee-after-transfer             | ownership-cannot-change              | total-supply-integrity               | user-cannot-exclude-include-from-fee | validate-transfer-diff-o-s-r         | validate-transfer-same-o-r           | validate-transfer-same-o-s           | validate-transfer-same-o-s-r         | validate-transfer-same-s-r           |
|--------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|
| **v1** | FP!                                  | UNK                                  | TN!                                  | ND                                   | UNK                                  | TP!                                  | UNK                                  | UNK                                  | UNK                                  | UNK                                  | UNK                                  |
 


### Certora
|        | liquidity                            | owner-can-exclude-include-from-fee   | owner-fee-after-transfer             | ownership-cannot-change              | total-supply-integrity               | user-cannot-exclude-include-from-fee | validate-transfer-diff-o-s-r         | validate-transfer-same-o-r           | validate-transfer-same-o-s           | validate-transfer-same-o-s-r         | validate-transfer-same-s-r           |
|--------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|
| **v1** | FP!                                  | TP!                                  | TN                                   | TP!                                  | TN                                   | TP!                                  | TN                                   | TN                                   | TN                                   | TN                                   | TN                                   |
 

