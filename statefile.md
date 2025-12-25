### State file drawbacks
- stores sensitive information and the file might be in VCS so it is vulnerable if tored unencrypted
- only after applying the changes described in .tf the state file is created
- "terraform show" shows whether state file is created or not
- consistency issues --- leading to race conditions
- single point of failure


### Fixes concurrency 
- uses remote backend
