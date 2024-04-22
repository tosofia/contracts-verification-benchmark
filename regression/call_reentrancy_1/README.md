# Usecase Template

## Specification


## Properties
- **foo**: Contract balance is not zero when `f()` is called.

## Ground truth
|        | checkX |
|--------|--------|
| **v1** | 0      |
 

## Experiments
### SolCMC
#### Z3
|        | checkX |
|--------|--------|
| **v1** | TN!    |
 

#### ELD
|        | checkX |
|--------|--------|
| **v1** | TN     |
 


### Certora
|        | checkX |
|--------|--------|
| **v1** | TN     |
 

