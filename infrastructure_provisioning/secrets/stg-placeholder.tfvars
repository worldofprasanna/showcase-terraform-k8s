# Place the values for the variables here
# Note: This is dummy values of the variable
environment="stg"
aws_region="us-east-1"
cluster-name="cats-cluster"
# VPC
vpc_cidr="10.0.0.0/16"
public_subnet1_cidr="10.0.1.0/24"
public_subnet2_cidr="10.0.2.0/24"
private_subnet1_cidr="10.0.3.0/24"
private_subnet2_cidr="10.0.4.0/24"
# DB
instance_class="db.t2.micro"
storage="10"
db_username="dummy"
db_password="dummy"
# EKS
eks_worker_instance_type="t3.medium"
eks_worker_min_nodes="1"
eks_worker_max_nodes="1"
eks_worker_desired_nodes="1"

# Populate from vpc run
vpc_id=""
db_security_group_id=""
web_security_group_id=""
private_subnet1_id=""
private_subnet2_id=""
public_subnet1_id=""
public_subnet2_id=""
