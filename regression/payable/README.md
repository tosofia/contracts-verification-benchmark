# Payable

## Specification
The contract transfer a specific amount of ether only if its balance is equal to another specified value.

## Properties
- **g-check-balance**: checks that the function `g()` transfers the correct amount of ether

## Ground truth
|        | g-check-balance |
|--------|-----------------|
| **v1** | 1               |
 

## Experiments
### SolCMC
#### Z3
|        | g-check-balance |
|--------|-----------------|
| **v1** | UNK             |
 

#### ELD
|        | g-check-balance |
|--------|-----------------|
| **v1** | FN              |
 


### Certora
|        | g-check-balance |
|--------|-----------------|
| **v1** | FN              |
 

