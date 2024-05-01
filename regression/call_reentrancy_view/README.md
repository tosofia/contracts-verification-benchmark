# Reentrancy view

## Specification
The `f` function performs an external call. `s` is a view function, which means it cannot modify x value.

## Properties
- **f-reentrancy-view-x**: `s()` is a view function so x must hold his value after `f()` is called.

## Ground truth
|        | f-reentrancy-view-x |
|--------|---------------------|
| **v1** | 1                   |
 

## Experiments
### SolCMC
#### Z3
|        | f-reentrancy-view-x |
|--------|---------------------|
| **v1** | ERR                 |
 

#### ELD
|        | f-reentrancy-view-x |
|--------|---------------------|
| **v1** | FN                  |
 


### Certora
|        | f-reentrancy-view-x |
|--------|---------------------|
| **v1** | TP!                 |
 

