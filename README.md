### Installations:
on Mac:
Install terraform - https://formulae.brew.sh/formula/terraform
Install AWS CLI - https://formulae.brew.sh/formula/awscli

### Credentials configuration:
1. Create a user in IAM User and have programatic access
2. Configure credentials: type 
in CLI type the command: aws configure
or export the access and secret key 
    export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
    export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

### Work Flow Execution to create ECS cluster : Infra steps 
1. Create VPC
2. Create ECR
3. Create ECS cluster
4. Create Fargate service 


### Terraform command exection commands

terraform init -backend-config="key={ENV}_${USER}/terraform.tfstate" or
1. terraform init -backend-config="key=dev_ecs_infra_Deepika/terraform.tfstate" 
2. terraform fmt
3. terraform validate
4. terraform plan -var-file=dev_ecs_infra_terraform.tfvars -out dev_ecs_infra_Deepika.out > dev_ecs_infra_Deepika.txt
5.terraform apply "dev_ecs_infra_Deepika.out"
6. terraform destroy -var-file=dev_ecs_infra_terraform.tfvars


