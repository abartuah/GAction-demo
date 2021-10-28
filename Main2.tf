provider "aws" {
  region     = "us-east-2"
  
}

resource "aws_instance" "my-server" {
  ami           = "ami-00399ec92321828f5"
  instance_type = "t2.micro"
  availability_zone = "us-east-2a"
  key_name = "hall2"

  user_data = <<-EOF
           #!/bin/bash
           yum update -y
           yum install httpd -y
           systemctl start httpd
           systenctl enable httpd
           echo " this is my first web -server" > /var/www/html/index.html
           EOF
    tags = {
      name = "myserver"
    }  
}    

terraform {
       backend "remote" {
         # The name of your Terraform Cloud organization.
         organization = "mizaorg"

         # The name of the Terraform Cloud workspace to store Terraform state files in.
         workspaces {
           name = "GAction-demo"
         }
       }
     }