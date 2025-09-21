## Random Questions

#### what is the use of .tfstate file?
  - remote collaboration : if it is stored in a common storage like S3 when multiple ppl work it ensures everyone is in sync
  - tracks existing resources
  - detects changes
  - identifies the dependencies
  - enables idempotency

#### what is idempotency?
  - even when terraform apply is run multiple times without changing the code there wont be any changes in the infra
  - bcz it keeps comparing the desired state and actual state
  
#### what if the .tfstate file gets deleted?
  - terraform loses track of all exsisting resources
  - when terraform apply is given it tries to create all the resources
  - but this might cause duplicate resources,conflicts or errors
    
#### how to prevent this deletion?
  - use remote state(local state means state file is in local machine) : Store state in S3, Terraform Cloud, or other backends

#### what is state locking?
 - when terraform updates the infra , it writes the changes to the .tfstate file
 - when multiple people run "terraform apply" it could overwrite each other's changes
 - so state locking ensures only one process can modify the state at the same time
         - w/o locking : state corruption,resources could be overwritten or destroyed
  
#### how state locking is achieved ? - *prevents concurrent writes to the state file*
- in local state : there is no need of locking
- in remote state : store the file in S3,GCP cloud
- depending on the backend we use there are different ways to achieve locking
- for aws S3+dynamoDB is used(S3 : stores the file so team can access ,DynamoDB - for locking)
  
#### How it Works Step-by-Step
- Terraform wants to run apply.
- checks DynamoDB to see if the state is locked.
- If locked → Terraform waits until the lock is released.
- If not locked → Terraform creates a lock entry.
- Terraform reads/writes the state file in S3 during the run.
- then tf removes the lock from DynamoDB.
- if the lock is not released (e.g., process crashes), you can manually unlock it using: terraform force-unlock <LOCK_ID>

  *here locking means just creating a lock record with timestamp,lock id and who locked it*
  
####
