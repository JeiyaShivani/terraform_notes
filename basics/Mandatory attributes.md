AWS Provider
```hcl
provider "aws" {
  region = "<region>"
}
```
VPC
```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
```
Subnet
```hcl
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
}
```
Security Group
```hcl
resource "aws_security_group" "sg" {
  name        = "my_sg"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.main.id
}
```
EC2 Instance
```hcl
resource "aws_instance" "web" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
}
```
S3 Bucket
```hcl
resource "aws_s3_bucket" "bucket" {
  bucket = "my-unique-bucket-name"
}
```
IAM Role
```hcl
resource "aws_iam_role" "role" {
  name               = "my_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}
```
