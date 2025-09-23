## Multi region setup
- use the alias keyword in the provider block to work with different accounts or regions
- naming a provider setup so Terraform knows which region or account to use

hcl
```
provider "aws" {
  region = "us-east-1"   # Default
}

provider "aws" {
  alias  = "west"
  region = "us-west-2"   # Nicknamed 'west'
}

resource "aws_instance" "east_vm" {
  ami           = "ami-123"
  instance_type = "t2.micro"
  provider      = aws          # Uses default
}

resource "aws_instance" "west_vm" {
  ami           = "ami-456"
  instance_type = "t2.micro"
  provider      = aws.west     # Uses 'west'
}
```
## Multi cloud

hcl
```
provider "aws" {
  region  = "us-east-1"
  profile = "aws-profile"
}

# Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "xxxx-xxxx-xxxx-xxxx"
  client_id       = "xxxx-xxxx-xxxx-xxxx"
  client_secret   = "xxxx-xxxx-xxxx-xxxx"
  tenant_id       = "xxxx-xxxx-xxxx-xxxx"
}
```
