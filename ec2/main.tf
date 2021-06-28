terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  profile = "free"
  region  = "ap-southeast-1"

}

resource "aws_default_vpc" "nam_test" {
  tags = {
    Name = "nam_test"
  }
}
resource "aws_default_subnet" "nam_test" {
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "nam_test"
  }
}

resource "aws_network_interface" "nam_test" {
    subnet_id = aws_default_subnet.nam_test.id 

    tags = {
        Name = "nam_test"
    }
}

resource "aws_ebs_volume" "nam_test" {
    availability_zone = "ap-southeast-1a"
    size = 100
    tags = {
        Name = "nam_test"
    }
  
}


resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.nam_test.id
  instance_id = aws_instance.nam_test.id
}
resource "aws_instance" "nam_test" {
    ami           = var.ami
    instance_type = "m5.xlarge"
    network_interface {
        network_interface_id = aws_network_interface.nam_test.id
        device_index = 0
    }
    root_block_device  {
        volume_size = 30
        volume_type = "gp2"
    }
    key_name = "free"
    tags = {
        Name = "nam_test"
    }


}
