provider "aws" {
    region = var.aws_region
  
}

# Create VPC
resource "aws_vpc" "altschool-11-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    "Name" = "altschool-11-vpc"
  }
}

resource "aws_internet_gateway" "altschool-11-igw" {
  vpc_id = aws_vpc.altschool-11-vpc.id
  tags = {
    "Name" = "altschool-11-igw"
  }
}

# Create public route table
resource "aws_route_table" "altschool-11-route-table-public" {
  vpc_id = aws_vpc.altschool-11-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.altschool-11-igw.id
  }

  tags = {
    Name = "altschool-11-route-table-public"
  }
}

# Associate public subnet 1 with public route table
resource "aws_route_table_association" "altschool-11-public-subnet1-association" {
  subnet_id = aws_subnet.altschool-11-public-subnet1.id
  route_table_id = aws_route_table.altschool-11-route-table-public.id
}

# Associate public subnet 2 with public route table
resource "aws_route_table_association" "altschool-11-public-subnet2-association" {
  subnet_id = aws_subnet.altschool-11-public-subnet2.id
  route_table_id = aws_route_table.altschool-11-route-table-public.id
}

# Associate public subnet 3 with public route table
resource "aws_route_table_association" "altschool-11-public-subnet3-association" {
  subnet_id = aws_subnet.altschool-11-public-subnet3.id
  route_table_id = aws_route_table.altschool-11-route-table-public.id
}

# # Create public subnets
# resource "aws_subnet" "public_subnets" {
#   count = length(var.public_subnet_cidrs)
#   vpc_id = aws_vpc.altschool-11-vpc.id  
#   cidr_block = element(var.public_subnet_cidrs, count.index)
#   availability_zone = element(var.availability_zones, count.index)
#   map_public_ip_on_launch = true

#   tags = {
#     "Name" = "altschool-11-public-subnet-${element(var.availability_zones, count.index + 1)}"
#   }
# }

#Create public subnet1
resource "aws_subnet" "altschool-11-public-subnet1" {
  vpc_id = aws_vpc.altschool-11-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"
  tags = {
    "Name" = "altschool-11-public-subnet1"
  }
}



#Create public subnet2
resource "aws_subnet" "altschool-11-public-subnet2" {
  vpc_id = aws_vpc.altschool-11-vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1b"
  tags = {
    "Name" = "altschool-11-public-subnet2"
  }
}

#Create public subnet2
resource "aws_subnet" "altschool-11-public-subnet3" {
  vpc_id = aws_vpc.altschool-11-vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1c"
  tags = {
    "Name" = "altschool-11-public-subnet3"
  }
}

# Create a security group for the load balancer

resource "aws_security_group" "altschool-11-load-balancer-sg" {
  name = "altschool-11-load-balancer-sg"
  description = "Security group for the load balancer"
  vpc_id = aws_vpc.altschool-11-vpc.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "altschool-11-load-balancer-sg"
  }
}

# Create a security group to allow 22, 80 and 443

resource "aws_security_group" "altschool-11-security-group-rule" {
  name = "Allow-ssh-http-https"
  description = "Allow SSH, HTTP and HTTPS inbound traffic for private instances"
  vpc_id = aws_vpc.altschool-11-vpc.id

  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.altschool-11-load-balancer-sg.id]
  }

    ingress {
    description = "HTTPs"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.altschool-11-load-balancer-sg.id]
  }

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "altschool-11-security-group-rule"
  }
}

# Creating instances
resource "aws_instance" "altschool11-server1" {
    ami = "ami-0333305f9719618c7"
    instance_type = "t2.micro"
    key_name = "altschool-key"
    security_groups = [aws_security_group.altschool-11-security-group-rule.id]
    subnet_id = aws_subnet.altschool-11-public-subnet1.id
    availability_zone = "eu-west-1a"

    tags = {
      Name = "altschool11-server1"
      Source = "terraform"
    }
  
}

resource "aws_instance" "altschool11-server2" {
    ami = "ami-0333305f9719618c7"
    instance_type = "t2.micro"
    key_name = "altschool-key"
    security_groups = [aws_security_group.altschool-11-security-group-rule.id]
    subnet_id = aws_subnet.altschool-11-public-subnet2.id
    availability_zone = "eu-west-1b"

    tags = {
      Name = "altschool11-server2"
      Source = "terraform"
    }
  
}

resource "aws_instance" "altschool11-server3" {
    ami = "ami-0333305f9719618c7"
    instance_type = "t2.micro"
    key_name = "altschool-key"
    security_groups = [aws_security_group.altschool-11-security-group-rule.id]
    subnet_id = aws_subnet.altschool-11-public-subnet1.id
    availability_zone = "eu-west-1a"

    tags = {
      Name = "altschool11-server3"
      Source = "terraform"
    }
  
}

# Create a file to store the IP addresses of the instances
resource "local_file" "IP_Addresses" {
    filename = "/home/motunrayo/Documents/Altschool-Cloud-Exercises/Mini-Project2/host-inventory"
    content = <<EOT
    ${aws_instance.altschool11-server1.public_ip}
    ${aws_instance.altschool11-server2.public_ip}
    ${aws_instance.altschool11-server3.public_ip}
    EOT
}

# Create an application load balancer
resource "aws_lb" "altschool-11-load-balancer" {
  name = "altschool-11-load-balancer"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.altschool-11-load-balancer-sg.id]
  subnets = [aws_subnet.altschool-11-public-subnet1.id, aws_subnet.altschool-11-public-subnet2.id]
  enable_deletion_protection = false
  depends_on = [aws_instance.altschool11-server1, aws_instance.altschool11-server2, aws_instance.altschool11-server3]  
}

#Create a target group

resource "aws_lb_target_group" "altschool-11-target-group" {
  name = "altschool-11-target-group"
  target_type = "instance"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.altschool-11-vpc.id

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 15
    timeout = 3
    healthy_threshold = 3
    unhealthy_threshold = 3
  }
  
}

resource "aws_lb_listener" "altschool-11-listener" {
  load_balancer_arn = aws_lb.altschool-11-load-balancer.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.altschool-11-target-group.arn
  }
}

resource "aws_lb_listener_rule" "altschool-11-listener-rule" {
  listener_arn = aws_lb_listener.altschool-11-listener.arn
  priority = 1

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.altschool-11-target-group.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}

# Attach the target group to the load balancer
resource "aws_lb_target_group_attachment" "altschool-11-target-group-attachment1" {
  target_group_arn = aws_lb_target_group.altschool-11-target-group.arn
  target_id = aws_instance.altschool11-server1.id
  port = 80
}

resource "aws_lb_target_group_attachment" "altschool-11-target-group-attachment2" {
  target_group_arn = aws_lb_target_group.altschool-11-target-group.arn
  target_id = aws_instance.altschool11-server2.id
  port = 80
}

resource "aws_lb_target_group_attachment" "altschool-11-target-group-attachment3" {
  target_group_arn = aws_lb_target_group.altschool-11-target-group.arn
  target_id = aws_instance.altschool11-server3.id
  port = 80
}