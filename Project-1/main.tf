//to se a list of providers: terroform.io/docs/proveders 

# Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"
  access_key = "AKIAIJY4DVNGMTPQH4ZQ"
  secret_key = "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"
}
# adding keys here is not recommended! use a more secure way

# provisioning a resource
# EC2 = virtual machine
# in the provider page, there is a left menu to see the resources we want to build and how to build them

# resource "aws_instance" "terraform_vm" {
#     ami = "ami-0817d428a6fb68645"
#     instance_type = "t2.micro"
# }

#terraform_vm is the name of the resource, but it's internal to terraform, for a possible future reference in the rest of the code

# run 'terraform init'
# run 'terraform plan' it's optional but it's good to create the plan in order to check it's everything is good to go
# finally, run 'terraform  apply' to execute the resources creation
# -----------------------------------------------------------------------------------------------
# Plan: 1 to add, 0 to change, 0 to destroy.

# Do you want to perform these actions?
#   Terraform will perform the actions described above.
#   Only 'yes' will be accepted to approve.

#   Enter a value: yes

# aws_instance.terraform_vm: Creating...
# aws_instance.terraform_vm: Still creating... [10s elapsed]
# aws_instance.terraform_vm: Still creating... [20s elapsed]
# aws_instance.terraform_vm: Creation complete after 29s [id=i-08debc15174483e00]

# Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
# -------------
# the state file is created automatically

# IMPORTANT! If we run this code again, it WILL NOT create another ecs instance. Tarraform is declarative

# and this code tells it how we want the environment to be / look like

# lets now update the state.. adding a tag to the machine (commented out above code)

resource "aws_instance" "terraform_vm" {
    ami = "ami-0817d428a6fb68645"
    instance_type = "t2.micro"
    tags = {
        Name = "ubuntu"
    }
}

# when we run 'terraform plan' again, it shows the upcomming changes and sings a "~"  to what is beeing changed or added
# now let's delete the created resource. to do that use the command 'terraform destroy'or we can just comment out the
# resource declaration

# CREATING A VIRTUAL PRIVATE CLOUD - VPC AND A SUBNET REFERENCING THIS VPC
resource "aws_vpc" "first_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
      Name = "production"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.first_vpc.id      #this references the above resorce using its type and name and getting its id (all resources have an id)
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "prd-submet"
  }
}
# IMPORTANT! If we don't want to type 'yes' every time, we can pass '--auto-aprove' argument \o/
# IMPORTANT! The order of the resources declaratoin DOES NOT matter! How about that, ham? :D TF will figure out for us

# --------------------------
# ** .terraform folder **: this is generated when we do 'terraform init'. It checks the provider we wanna use and downloads all the plugins 
# for that provider
# ** terraform.tfstate ** : stores details of the resources created. DO NOT mess around with this file!
