##Installation
Follow this link to install terraform -> https://www.terraform.io/intro/getting-started/install.html

##Configuration
1. Create IAM user(s) with policy `AdministratorAccess` from AWS IAM console of root user. Save the access keys of the user which will be used to create the infra via terraform.
2. Configure aws keys:
   - Install aws cli and configure by calling `aws configure`
   - The project root contains a file named terraform.tfvars.example. Rename that file to terraform.tfvars and populate it with your AWS credentials:
      
      `$ mv terraform.tfvars.example terraform.tfvars`  
      `$ vim terraform.tfvars`

3. Create ssh keys in the root dir of the repo 
   - either in file `mykey`,or
   - update the key name in vars.tf if created ssh keys in different file
   ![alt text](img/key-overwrite.png)
4. Replace key under `ssh-authorized-keys` in templates/init.cfg with your public key generated in file mykey.pub

   
      ![alt text](img/ssh-key-overwrite.png)
   

## Usage
The plan phase takes your Terraform configuration and attempts to provide you with a plan of what it would do if you applied it.
'terraform plan'

To apply the plan run `terraform apply`

To ssh into the ec2 box run `ssh -i mykey deployuser@node-ip`

To destroy the infrastructure created via terraform `terraform destroy`
