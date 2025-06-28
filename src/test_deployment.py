from pyboto3.appmesh import describe_route

from src.ec2.vpc import VPC
from src.client_locator import EC2Client
from src.ec2.ec2 import EC2

def main():
    # create a vpc
    ec2_client = EC2Client().get_client()
    vpc=VPC(ec2_client)

    vpc_response = vpc.create_vpc()
    print("VPC created:" + str(vpc_response))

    # add a name tag to the vpc
    vpc_name = 'Boto3 - VPC'
    vpc_id = vpc_response ['Vpc']['VpcId']
    vpc.add_name_tag(vpc_id, vpc_name)

    print('Added ' + vpc_name + vpc_id)

    # create an IGW
    igw_response = vpc.create_internet_gateway()
    igw_id = igw_response['InternetGateway']['InternetGatewayId']

    vpc.attach_igw_to_vpc(vpc_id, igw_id)

    #create a public subnet
    public_subnet_response = vpc.create_subnet(vpc_id, '10.0.0.0/16' )
    public_subnet_id= public_subnet_response['subnet'] ['SubnetId']
    print("subnet created for vpc" + vpc_id + ":" + str(public_subnet_response))

    #Add a name tag to the public subnet
    vpc.add_name_tag(public_subnet_id, 'Boto3-Public-Subnet')

    #create a public route table
    public_route_table_response= vpc.create_public_route_table(vpc_id)

    rtb_id = public_route_table_response['RouteTable']['RouteTableId']
    #adding IGW to public route table
    vpc.create_igw_route_to_public_route_table(rtb_id, igw_id)

    #Associate subnet with route table
    vpc.associate_subnet_with_route_table(public_subnet_id, rtb_id)

    #allow auto assign public Ip addresses for subnet
    vpc.allow_auto_assign_ip_addresses_for_subnet(public_subnet_id)

    #create a private subnet
    private_subnet_response = vpc.create_subnet(vpc_id, '10.0.2.0/24')
    private_subnet_id = private_subnet_response['Subnet']['SubnetId']
    print("subnet created for vpc" + vpc_id + ":" + str(private_subnet_response))

    #Add a name tag to the private subnet
    vpc.add_name_tag(private_subnet_id, 'Boto3-Private-Subnet')

    #EC2 instances
    ec2 = EC2(ec2_client)

    # create a key pair
    key_pair_name = 'Boto3-keypair'
    key_pair_response = ec2.create_key_pair(key_pair_name)

    print("Created key pair with name : "+ key_pair_name + ":" + str(key_pair_response))

    # create a security group
    public_security_group_name = 'Boto3-public_SG'
    public_security_group_description = 'Public Security Group for public subnet internet access'
    public_security_group_response = ec2.create_security_group(public_security_group_name, public_security_group_description, vpc_id)

    public_security_group_id = public_security_group_response['GroupId']

    # add inbound rules to the security group
    ec2.add_inbound_rule_to_security_group(public_security_group_id)
    print("Added public access rule to security group " + public_security_group_name)

    user_data = """#!/bin/bash
                yum update -y
                yum install httpd24 -y
                service httpd start
                chkconfig httpd on
                echo "<html><body><h1>Hello from <b>boto3<b> using python !</h1></body></html>" >/var/www/html/index.html"""

    # launch EC2 instance in public subnet
    ami_id = 'ami-0229b8f55e5178b65'

    #launch a public EC2 instance
    ec2.launch_ec2_instance(ami_id,key_pair_name, 1,1, public_security_group_id, public_subnet_id, user_data)
    print("Launching public ec22 instances using ami ami-0229b8f55e5178b65")

    #Adding another security grp for private EC2 instance
    private_security_group_name = 'Boto3-private_SG'
    private_security_group_description = 'Private Security Group for private subnet internet access'
    private_security_group_response = ec2.create_security_group(private_security_group_name, private_security_group_description, vpc_id)

    private_security_group_id = private_security_group_response['GroupId']

    # add rule to the private security group
    ec2.add_inbound_rule_to_security_group(private_security_group_id)

    #launch a private EC2 instance
    ec2.launch_ec2_instance(ami_id, key_pair_name, 1, 1, private_security_group_id, private_subnet_id,"""""" )


if __name__ == "__main__":
    main()


