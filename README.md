# README.md

## Table of Contents:

* [Introduction](#introduction)
* [Setup Instruction](#setup-instructions)
    * [Create user IAM](#create-user-iam)
    * [Run Terraform](#run-terraform)

## Introduction
This repository contains the Infrastructure as Code (IaC) for UITGO, using Terraform to automate the deployment of AWS resources.

## Setup Instructions:
1. **Create user IAM**
- Go to IAM section in AWS Management Console
![IAM_section](assets/IAM_section.png)
- In the left panel, select Users
![Users_section](assets/Users_section.png)
- Click Create user, then enter a username of your choice
![Create_user](assets/create_user.png)
- Choose attach the necessary policies. Under Permissions policies, choose AdministratorAccess in order to allow Terraform full access to manage resources
![Set_Permisssions](assets/set_permissions.png)
- Once the user is created, it will appear in the users list
![User](assets/User_IAM.png)
- Click on that user and go to ``Security Credentials`` tab
![Credentials](assets/Credentials.png)
- Scroll down to ``Access keys``, then click ``Create access key``
![Access_key](assets/Access_key.png)
- In use case section, select ``CLI``, check the box for ``I understand the above recommendation and want to proceed to create an access key.``
![Use_case](assets/Use_case.png)
- After creating access keys, we can either download the CSV file to save the keys or copy them directly (secret access key is only shown once)
![retrieve_keys](assets/retrieve_keys.png)

2. **Run Terraform**
- Clone the repo
```bash
https://github.com/UITgo/IaC.git
cd UITGO
```

- In terminal, cd UITGO, and configure your aws
```bash
aws configure
```
![aws_configure](assets/aws_config.png)

- Initialize Terraform
```bash
terraform init
```

- Ensures your configuration syntax and structure are correct
```bash
terraform validate
```

- Preview the Deployment. This shows all resources that Terraform will create, modify, or destroy

```bash
terraform plan
```

- Apply the Configuration
```bash
terraform apply
```