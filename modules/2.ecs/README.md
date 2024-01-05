Steps to Create ECS with Fargate are :

Status for below task: Done 
1. Create ECS cluster
	Name the cluster
	Create VPc → associate with the one created 

Status for below task: completed
2. Create IAM Roles for below 3rd task
    a)  do this Before creating task definition to call API request on behalf of AWS services(optional)
    b) Task execution role -> to pull container images and publish logs to amazon cloudwatch on your behalf

Status for below task: Completed
3. Create Task Definition -> To run containers in this cluster
    a) Launch type - > Fargate or EC2 :: we are using Fargate
	    Task definition name
        create IAM role and attach task definition role : Step2
        network mode default awsvpc for fargate
        assign task size, memory etc 
        Aa) Under task size, define no.of containers Under Containers definitions
            Add container - name 
            image id (lookup from ECR), 
            Private repo authentication
            Memory soft limit (minimum memory to be assigned to container)
            If its hard limit then whatever is defined at task level and based on utilization,it will be assigned on demand
            Port mapping - container port [ports should be same 6789:6789 else you will get error]
            Add additional checks if needed else leave it
            Create tags

Status for below task: Completed
4. Service - to create multiple tasks with ALB
    You can have a Load balancer here to load balance to these tasks on ECS cluster
    MAIN STEP1 :First Create ALB
    MAIN STEP2: create Service that includes AutoScaling too if needed

MAIN STEP1 :First Create ALB
     a) Create Target group
        Target group name
        Target type -> ip
        Port 8080 exposed to docker
        Vpc
        Add health check settings
     b) Create Load Balancer
        Load balancer name
        Internet facing or internal
        LISTENERS: Http port: 80
        AVAILABILITY ZONE: select 2 or 3 (subnets selection)
        Security settings (ignore as we are not using HTTPS)
        SECURITY GROUP: create a new SG with http 80 and source anywhere (internet) i.e any ip can reach Load balancer
        CONFIGURE ROUTING: target group select the one created, rest details ae auto populated as we did it for TG
        REGISTER TARGETS are pending here so that… once ECS tasks are created , we can add them to TG.


MAIN STEP2: create Service that includes AutoScaling too if needed
        Goto cluster-> click on clustername-> create service
        a. Launch type -> fargate
        Task definition -> select the one you created
        Revision -> latest
        cluster-> clustername
        Service name -> provide service name
        Service type ->  replica (automatically takes it default one
        No of tasks - 3  (creates 3 tasks /replica)
        DEPLOYMENT TYPE - ROLLING / BLUE GREEN
        CONFIGURE NETWORK:
            CLUSTER vpc
            Subnets
        Security group for tasks, allow traffic only from load balancer to ECS/containers
        Auto assign public group
        LOAD BALANCING - select application load balancer
        Container to load balancer : 8080
        Target group map to created one.
        Autoscaling if needed


NOTE: 1. Security Group for ALB -> allow Traffic from IG to ALB
      2. Security Group for Tasks  -> allow traffic from ALB to ECS_TASK 


