# AWS Transit Gateway lab environment

## Introduction

This is a modified/simplified version of the template which can be found at : https://github.com/aws-samples/transit-gateway-single-exit-point

File | Description
------------ | -------------
[**AWS-TGW-Lab.yaml**](https://github.com/zscaler-bd-sa/AWS/blob/main/Zscaler/AWS-TGW-Lab/AWS-TGW-Lab.yaml) | Cloudformation template to create AWS TGW lab

This cloudformation template automatically creates a slightly modified/simplified version of what is described in the blog referenced in the template above, but can be tested using the steps in the blog.

The architecture...

<img src="https://github.com/zscaler-bd-sa/AWS/blob/main/Zscaler/AWS-TGW-Lab/images/AWS-TGW-Lab-Diagram.png">

## Running the cloudformation template

This cloudformation template can be used to create a [stack](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacks.html), either via the Console, AWS CLI, or the Cloudformation Designer. You will need to input your source IP to restrict SSH to the Bastion host, and your Keypair to use. This should then create the entire environment, including the three EC2 instances, and be ready for you to test with.

## How I tested the deployed environment

For testing, I followed the "Testing the deployment" section in the [AWS Blog](https://aws.amazon.com/blogs/networking-and-content-delivery/creating-a-single-internet-exit-point-from-multiple-vpcs-using-aws-transit-gateway/) (referenced in the original sample AWS template link above) and connected to the Bastion host via SSH, copied my Keypair to the Bastion host, and connected to the App instances to validate that they could fetch content from the Internet but could not connect to the other App/VPC. I did need to omit the blackhole route for 192.168.0.0/16 mentioned in the blog in order to route back to the Bastion host.

## Support and reporting issues

This template is released under an as-is, best effort, support policy. Please report any issues through Github repo issue tracking.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.
