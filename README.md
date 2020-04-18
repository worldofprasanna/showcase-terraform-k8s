# screener

[![standard-readme compliant](https://img.shields.io/badge/standard--readme-OK-green.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

> Infrastructure repository for deploying the cat app

If you want to know about the requirements against this repo is built take a look here [Requirements](Requirements.md)
If you want to know about the technologies used, please refer to [Tech Stack](TechStack.md)

Note: The app is a very basic one, but the infrastructure is much more complex and can be scaled easily. This could be an over engineering for such a simple app, but this is just a repository to showcase my take on infrastructure. Though its fully functional and throughly tested, please use it with caution in production applications.

## Table of Contents

- [screener](#screener)
  - [Table of Contents](#table-of-contents)
  - [Install](#install)
  - [Usage](#usage)
  - [Maintainers](#maintainers)
  - [Contributing](#contributing)

## Install

1. Install Terraform
```
brew install terraform
```

## Usage

Check the Terraform Guide to run the scripts [here](TerraformGuide.md)
Note: Replace the <aws-account-id> with your actual id in the corresponding chart's values.yml

1. To create all the resources from scratch
```
cd infrastructure_provisioning
./deployer/install.sh all stg
```
2. To create specific resource,
```
cd infrastructure_provisioning
./deployer/install.sh <resource> stg
```
3. To delete all the resources
```
cd infrastructure_provisioning
./deployer/delete.sh all stg
```
4. To delete specific resource
```
cd infrastructure_provisioning
./deployer/delete.sh <resource> stg
```

## Maintainers

[@worldofprasanna](https://github.com/worldofprasanna)

## Contributing

PRs accepted.

Small note: If editing the README, please conform to the [standard-readme](https://github.com/RichardLitt/standard-readme) specification.
