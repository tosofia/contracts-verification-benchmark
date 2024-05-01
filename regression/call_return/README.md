# Call Revert

## Specification
The contract performs an external call and checks if the call failed or not. The properties should both fail since we cannot know if the call will fail or not.

## Properties
- **call-not-revert**: checks if the external call succeeded
- **call-revert**: checks if the external call failed

## Ground truth
|        | call-not-revert | call-revert     |
|--------|-----------------|-----------------|
| **v1** | 0               | 0               |
 

## Experiments
### SolCMC
#### Z3
|        | call-not-revert | call-revert     |
|--------|-----------------|-----------------|
| **v1** | TN!             | TN!             |
 

#### ELD
|        | call-not-revert | call-revert     |
|--------|-----------------|-----------------|
| **v1** | TN              | TN              |
 


### Certora
|        | call-not-revert | call-revert     |
|--------|-----------------|-----------------|
| **v1** | TN              | TN              |
 

