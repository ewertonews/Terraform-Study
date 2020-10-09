# -------------------------
# PRACTICAL PROJECT


provider "aws" {
    region  = "us-east-1"
    access_key = "AKIAIJY4DVNGMTPQH4ZQ"
    secret_key = "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"
}

# 1. Create VPC
resource "aws_vpc" "study_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "study"
    }
}

# 2. Create and Internet Gateway
resource "aws_internet_gateway" "study_gateway" {
    vpc_id = aws_vpc.study_vpc.id

    tags = {
        Name = "study"
    }
}

# 3. Create Custom Route Table
resource "aws_route_table" "study_routetable" {
    vpc_id = aws_vpc.study_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.study_gateway.id
    }

    route {
        ipv6_cidr_block        = "::/0"
        egress_only_gateway_id = aws_internet_gateway.study_gateway.id
    }

    tags = {
        Name = "Study-RouteTable"
    }
}

# 4. Create a Subnet
resource "aws_subnet" "subnet_study" {
    vpc_id     = aws_vpc.study_vpc.id      #this references the above resorce using its type and name and getting its id (all resources have an id)
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "study-submet"
    }
}

# 5. Assossiate subnet with Route Table
resource "aws_route_table_association" "study_routetableassociation" {
  subnet_id      = aws_subnet.subnet_study.id
  route_table_id = aws_route_table.study_routetable.id
}

# 6. Create a Security group to allow ports 22, 80 and 443
resource "aws_security_group" "allow_web" {
  name        = "allow_web_trafic"
  description = "Allow WEB traffic"
  vpc_id      = aws_vpc.study_vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #any ip can access. putting an ip here would allow that ip
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #any ip can access. putting an ip here would allow that ip
  }

  ingress {
    description = "SSH"
    from_port   = 2
    to_port     = 2
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #any ip can access. putting an ip here would allow that ip
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #any protocol
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}
# 7. Create a network interface with an ip in the subnet that was created in step 4
# 8. Assing an elastic IP to the network interface created in step 7
# 9. Create Ubuntu server and install/enable apache2