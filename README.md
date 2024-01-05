### Details about this Terraform project code: 
```
This Terraform Code is created for a Dockerized application : https://github.com/kanwardeepika91/vue-js-node-js-express-mysql.git
```
1. The Application infrastructure of above git project is mainly to host the application on AWS ECS Fargate
2. docker-compose is been used for application + mysql and automated deployment using AWS Codepipeline *(Documentation is in progress))*
3. NOTE: You can also create a seperate container for Mysql and create a AWS RDS to host mysql.

### Installations:
on Mac:
Install terraform - https://formulae.brew.sh/formula/terraform
Install AWS CLI - https://formulae.brew.sh/formula/awscli

### Credentials configuration:
1. Create a user in IAM User and have programatic access
2. Configure credentials: type 
in CLI type the command: aws configure
or export the access and secret key  (have admin access or IAM role should have admin access to create Infrastructure )
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


ERRROS: faced during code testing
 
```
 Error1: creating ECS Task Definition (dev-ecs-app-task):
  ClientException: When networkMode=awsvpc, the host ports and container ports in port mappings must match.
 Solution: changed to 6789 for both ports 
```

```
Error2: --InvalidSubnet: The subnet ID '172.31.0.0/20' is not valid
 │ Error: creating ELBv2 application Load Balancer (dev-ecs-alb): InvalidSubnet: The subnet ID '172.31.0.0/20' is not valid
│       status code: 400, request id: 8db13b75-5212-493b-af90-ea12e0b26811
Solution: pass subnet ids properly as its taking CIDR block value 
```