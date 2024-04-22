# Reentrancy

## Specification


## Properties
- **f-reentrancy-x**: Because of reentrancy x may not be zero after `f()` is called.

## Ground truth
|        | f-reentrancy-x |
|--------|----------------|
| **v1** | 0              |
 

## Experiments
### SolCMC
#### Z3
|        | f-reentrancy-x |
|--------|----------------|
| **v1** | TN!            |
 

#### ELD
|        | f-reentrancy-x |
|--------|----------------|
| **v1** | TN             |
 


### Certora
|        | f-reentrancy-x |
|--------|----------------|
| **v1** | TN             |
 

