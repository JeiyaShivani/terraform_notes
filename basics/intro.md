## Introduction
terraform - an open source IaC tool which is used to manage infrastructure
- so it has three main parts : 
      1.terraform core - this handles the state management,.tf parsing , planning etc
      2.provider plugins - talks to cloud providers
      3.state file(terraform.tfstate) - tracks the last known state of all resources that terraform manages and defined in main.tf

### Internal working
 #### terraform init 
   - this sets up a working directory (in the folder where we write the .tf files,terraform will initialize .terraform/ folder)
   - it does not create any resources yet
   - it stores the metadata,fetch modules,downloads provider binaries
           - providers are plugins or drivers that contain code which will translate the resource definition to API calls
           -API calls will talk to AWS to provision the resources
   -it prepares the backend environment
#### terraform plan
- outputs an execution plan showing Create, Update, or Destroy actions.
- terraform will do this by comparing the actual state and desired state
- actual state → What actually exists in the cloud
- desired state → What you want (code in .tf files)
      - there could be three cases
            1.when the resource is already there : then tf doesnt create anything
            2.the resource is there but properties have been changed : the tf plans to update it(like properties of an S3 bucket)
            3.or it could have been deleted and tf plans accordingly ( + : create,~ :update,- :delete)
#### terraform apply
- it actually again refreshes the .tfstate file and then checks the actual state again to see if anyone has made any changes after the last plan
- generates the final execution plan and then API calls is made and resources are created through provider plugins

#### terraform destroy
-removes all resources
how ?
      - reads the state file
      - builds the dependency graph to find the destruction order
      - then shows the execution plan
      -delete and update the state file again


### Questions:
1.what if the order of creation is wrong like subnet first then vpc?
- tf builds a dependency graph to understand the order of resource creation, update, or deletion.
- It automatically determines dependencies from your resource references:
- Example: subnet_id = aws_subnet.my_subnet.id → Terraform knows the subnet must exist before the instance.subnet depends on vpc etc

2.how does it build the directed acylic graph?
- it first parses the .tf file and finds the resources and its attributes
- then it finds the dependencies by looking at the references
  
  ``` hcl
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"} ```

- here the resource is subnet but there is vpc_id which is the reference
- then it builds a graph like structure nodes- resources and edges- dependency
- uses topological sort to sort the graph
- Independent resources which has no dependencies can be created in parallel to speed up deployment

3.what if you Don’t Mention Dependencies at All?
- then it gives error during terraform plan or terraform apply
- there are two types of dependency
       - explicit : defined like `depends_on    = [aws_s3_bucket.logs]`
     
     
     





