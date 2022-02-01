# App Connector AWS Deployment

## Introduction

Automated deployment options to install a ZPA App Connector in AWS.

File | Description
------------ | -------------
[**AppConnCFT.yaml**](https://github.com/zscaler-bd-sa/AWS/blob/main/Zscaler/App-Connector-AWS/AppConnCFT.yaml) | CloudFormation Template to install App Connector in AWS via GUI
[**AppConnCFT-CLI.yaml**](https://github.com/zscaler-bd-sa/AWS/blob/main/Zscaler/App-Connector-AWS/AppConnCFT-CLI.yaml) | CloudFormation Template to install App Connector in AWS via CLI
[**AppConnTF.tf**](https://github.com/zscaler-bd-sa/AWS/blob/main/Zscaler/App-Connector-AWS/AppConnTF.tf) | Terraform script to install App Connector in AWS cia CLI

## Installing

The examples in this directory allow you to automate the installation of a ZPA App Connector in AWS. These examples are designed to show options that can be used to automate the installation. Each AWS region has a unique App Connector AMI ID that must be identified before using. The AWS CLI can be used to find the AMI ID using the following command (modify for your region):

`aws ec2 describe-images --owners 'aws-marketplace' --filters 'Name=product-code,Values=3n2udvk6ba2lglockhnetlujo' --output 'text' --query 'sort_by(Images, &CreationDate)[-1].[ImageId]' --region us-east-2`

* AppConnCFT.yaml
  - Simple example meant to be installed via the AWS UI. Allows inputting all parameters including the source IP to allow connecting via SSH, the KeyPair to use, the ZPA Provisioning Key, the AMI ID, the instance type, and the VPC/Subnet to use.
  - Installs a ZPA App Connector in AWS with an external IP address assigned and a new Security Group allowing SSH access to it. The external IP assigned is output upon the completion of each file running.

* AppConnCFT-CLI.yaml
  - Simple example meant to be installed via the AWS CLI. All parameters including the source IP to allow connecting via SSH, the KeyPair to use, the ZPA Provisioning Key, the AMI ID, the instance type, and the VPC/Subnet to use must be input in the file before running.
  - Installs a ZPA App Connector in AWS with an external IP address assigned and a new Security Group allowing SSH access to it. The external IP assigned is output upon the completion of each file running.

* AppConnTF.tf
  - Simple example meant to be installed via the Terraform CLI. All parameters including the source IP to allow connecting via SSH, the KeyPair to use, the ZPA Provisioning Key, the AMI ID, the instance type, and the VPC/Subnet to use must be input in the file before running.
  - Installs a ZPA App Connector in AWS with an external IP address assigned and a new Security Group allowing SSH access to it. The external IP assigned is output upon the completion of each file running.

## Support and reporting issues

These files are released under an as-is, best effort, support policy. Please report any issues through Github repo issue tracking.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.
