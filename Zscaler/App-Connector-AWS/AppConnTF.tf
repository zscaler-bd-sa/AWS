locals {
    region = "us-west-2"
    vpc = "vpc-1a2b3c4d"
    ami = "ami-0749d7e1e06db6fae"
    itype = "m5a.xlarge"
    subnet = "subnet-a1b2c3d4"
    publicip = true
    keyname = "My_AWS_Keypair"
    sgdesc = "AppConnSG"
    myip = "12.34.56.78/32"
    mykey = "2|api.private.zscaler.com|aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZaAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZaAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZaAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZaAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZaAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZaAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ12345678901234567890"
}

provider "aws" {
  region = local.region
}

resource "aws_security_group" "appconn-sg" {
  name = "appconn-sg"
  description = local.sgdesc
  vpc_id = local.vpc #if commented, use the default

  #Incoming traffic
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [local.myip]
  }

  #Outgoing traffic
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "appconn-ec2" {
  ami = local.ami
  instance_type = local.itype
  vpc_security_group_ids = [aws_security_group.appconn-sg.id]
  subnet_id = local.subnet #if commented, use the default
  associate_public_ip_address = local.publicip
  key_name = local.keyname
  user_data = <<EOF
#!/bin/bash
#Stop the App Connector service which was auto-started at boot time
systemctl stop zpa-connector
#Copy App Connector provisioning key from the ZPA Admin Portal to file
#Make sure that the provisioning key is between double quotes
echo "${local.mykey}" > /opt/zscaler/var/provision_key
#Run a yum update to apply the latest patches
yum update -y
#Start the App Connector service to enroll it in the ZPA cloud
systemctl start zpa-connector
#Wait for the App Connector to download latest build
sleep 60
#Stop and then start the App Connector for the latest build
systemctl stop zpa-connector
systemctl start zpa-connector

EOF
}

output "AppConnPublicIP" {
  value = aws_instance.appconn-ec2.public_ip
}

output "AppConnPrivateIP" {
  value = aws_instance.appconn-ec2.private_ip
}
