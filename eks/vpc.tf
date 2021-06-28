module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.66.0"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-southeast-1a","ap-southeast-1b"]
  private_subnets = ["10.0.1.0/24","10.0.2.0/24"]

  tags = {
    Name = "eks-vpc"
  }
}

