variable "aws_region" {
    description = "region where resources will be created"
    type = string
    default = "eu-west-1"
}

variable "ami" {
    description = "id of the machine image (AMI)"
    type = string
    default = "ami-0333305f9719618c7"
}

variable "public_subnet_cidrs" {
    type = list(string)
    description = "public subnet CIDR values"
    default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "availability_zones" {
    type = list(string)
    description = "availability zones"
    default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}