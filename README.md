# Huawei Cloud Terraform root/member account demonstration

This project contains a minimal [Terraform](https://developer.hashicorp.com/terraform/docs)
demonstration for operation of [Huawei Cloud](https://www.huaweicloud.com/intl/en-us)
root and member accounts in a landing zone scenario, using AK/SK of IAM User in
root account.

## Structure

- `main.tf` - primary entrypoint;
- `variables.tf` - declarations for variables;
- `outputs.tf` - declarations for outputs;
- `providers.tf` - list required providers, versions and configurations;
- `terraform.tfvars` - derived from `terraform.tfvars.example`, contains custom
  values for variables. This file is not commited to the repository;
- `modules/root` - Root account infrastructure definitions;
- `modules/member` - Member account infrastructure definitions;

## Pre-requisites

- Root account with Organizations service enabled;
- Member account already created in Organizations service;
- IAM User in the root account with programmatic access, and with `Agent Operator`
  permission assigned (reference: <https://support.huaweicloud.com/intl/en-us/usermanual-iam/iam_01_0063.html>)

## Initial Steps

1. Make a copy of `terraform.tfvars.example` file named `terraform.tfvars` and
   set `hwc_access_key`, `hwc_secret_key` and `member_account_name` values.
   Access Key and Secret Key are from IAM User in the root account.
2. Run Terraform commands (e.g. `terraform init` and `terraform apply`)

## Resources demonstrated

Root account:
- IAM Identity Center user, group, permission set, permission set attachment to account
- Organizations trusted service (RAM)

Member account:
- Virtual Private Cloud and Subnet
- Subnet sharing to root account using Resource Access Manager (RAM)
