# screener

[![standard-readme compliant](https://img.shields.io/badge/standard--readme-OK-green.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

> Infrastructure repository for deploying the cat app

If you want to know about the technologies used, please refer to [Architecture](Architecture.md)

Note: CircleCI is used for CI/CD.

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
