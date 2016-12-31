##Configuration
There two way to configure aws key:
- Install aws cli and update key in `~/.aws`
- The project root contains a file named terraform.tfvars.example. Rename that file to terraform.tfvars and populate it with your AWS credentials:

$ mv terraform.tfvars.example terraform.tfvars
$ vim terraform.tfvars

## Usage
The plan phase takes your Terraform configuration and attempts to provide you with a plan of what it would do if you applied it.
'terraform plan'