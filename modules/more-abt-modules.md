### Root module
- this is where u ru terraform init,plan ,apply
- this calls other modules
- passes env specific values
### child module
- cant run terraform apply in this
- because when "terraform apply" is run , terraform needs a place where provider,region info,backend,dependency graph all this is defined which is inside root module
- in child module it is incomplete by design 

### structure of a module
- variables.tf
- main.tf
- outputs.tf

##### inside modules values should not be hardcoded because - all config must come from inputs
##### Module composition :
- using outputs of one module as inputs to another module
- ec2 module needs vpc and subnet id(which are created by vpc module)
- So you “compose” them like this:
- module "ec2" {
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_id }

##### Module chaining :

terraform says that every modules must talk to each other by using inputs and outputs 
bcz it has to Build a dependency graph and Know creation order and Avoid race conditions
- Root starts everything
- VPC module creates VPC
- VPC module outputs VPC ID
- Root receives the output
- Root passes it to EC2
- EC2 uses it
  





## Reusable means?
- it can be resused in 3 ways
  #### in environments
  - same code,diff values eg in dev and in prod
  #### in accounts
  - same infra can be created in two AWS accounts using terraform
  #### multiple infra
  - by calling the same module again with different names we can create multiple copies of the infra
    ##### calling means?
    - it simply means root module uses child modules as building blocks
    - module "vpc" {
      source = "./modules/vpc"  // or u could have to give the link of the github repo which has the module
      }

    
