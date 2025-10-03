variable "aws_region" {
  description = "AWS region to deploy into"
  default     = "us-east-2" # Ohio region 
}

variable "ami_id" {
  description = "AMI ID for Ubuntu 22.04 LTS in us-east-2"
  default     = "ami-0fb653ca2d3203ac1" # Ubuntu 22.04 LTS, current as of 2025
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "key_pair" {
  description = "SSH key pair name"
  default     = "logan-key"
}

