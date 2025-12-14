### advantages of modules
- modularity : like shifting from monolithic architecture to microservices it is easier to manage and maintain and test
- reusability : multiple teams can use the same module say EC2 instance module
- testing and validation - can be tested individually
- a scalabale approach to manage complexity
- easier versioning and maintenance
- A module is a folder containing Terraform code that creates one logical resource set and can be reused.

### Without modules:

- Everything is in main.tf
- Not reusable
- 1000+ lines
- Impossible to maintain

### With modules:

- Clean separation
- Resuability
- Same infra for dev, test, prod with different values
