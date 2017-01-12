##Configuration
1. There two way to configure aws key:
   - Install aws cli and update key in `~/.aws`
   - The project root contains a file named terraform.tfvars.example. Rename that file to terraform.tfvars and populate it with your AWS credentials:

   $ mv terraform.tfvars.example terraform.tfvars
   $ vim terraform.tfvars

2. Create ssh keys in file mykey or update the key name in vars.tf
3. Replace key under `ssh-authorized-keys` in templates/init.cfg with your public key

## Usage
The plan phase takes your Terraform configuration and attempts to provide you with a plan of what it would do if you applied it.
'terraform plan'

To apply the plan run `terraform apply`

To ssh into the ec2 box run `ssh -i mykey deployuser@node-ip`

To destroy the infrastructure created via terraform `terraform destroy`
