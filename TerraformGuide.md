# Guide to provision infrastructure

This guide will show the steps to be executed in order to provision the whole infrastructure.

Each resource is placed under its own folder. Reason: I do not want to run few resources always (eg: EKS - as it will incur charges) and I want to destroy it as a whole when I complete my testing.

Now there are scripts to perform these operations, instead of manually going into the folder and doing the operation.

Check the files [infrastructure_provisioning/deployer/install.sh](infrastructure_provisioning/deployer/install.sh) and [infrastructure_provisioning/deployer/delete.sh](infrastructure_provisioning/deployer/delete.sh)

To know about the repository and structure use the below information.

1. Create the VPCs
```
cd infrastructure_provisioning/vpc
terraform plan -out plan.out
terraform apply plan.out

# Copy the output variables (subnet ids etc)
```
2. Create the RDS database
```
# update the subnet and security group id in the stg.tfvars

cd infrastructure_provisioning/rds
terraform plan -out plan.out -var-file=stg.tfvars
terraform apply plan.out

# Copy the output variables (DB address)
```
3. Create the EKS cluster
```
# update the vpc, subnet and security group id in the stg.tfvars

cd infrastructure_provisioning/eks
terraform plan -out plan.out -var-file=stg.tfvars
terraform apply plan.out

# Copy the cluster connection information and update the kube config
```
4. Create the ECR registry
```
cd infrastructure_provisioning/ecr
terraform plan -out plan.out -var-file=stg.tfvars
terraform apply plan.out
```
5. Create the Helm chart repository
```
cd infrastructure_provisioning/helm_charts
terraform plan -out plan.out -var-file=stg.tfvars
terraform apply plan.out

# Initialise the repository for helm charts
./init_repo.sh
```

These steps would create the entire infrastructure.