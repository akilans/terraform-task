[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fakilans%2Fterraform-task&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

# Terraform Task

- Use Terraform and Ansible to achieve the below

### Requirements

- Create a VPC, use the CIDR of your choice. Also have internet gateway and the required routes
  defined
- Create an auto scaling group
- Create a web server instance
- Change the default web server TCP port from 80 to TCP 8080
- Create a load balancer and point the web server
- Open TCP port 80 on the security group to allow incoming traffic from the world
- Create a IAM user and grant him access to only restart web server

### Network module

- input variables - region,env,vpc_name,vpc_cidr_range,subnets(map(string))
- create vpc
- create 2 subnets
- create internet gateway
- attach internet gateway to default route table for the new vpc
- outputs - newly created vpc_id as string & subnets as list

### Autoscaling group module

- input variables - env,vpc_id, instance_type,desired, minimum, maximum counts for asg and subnets_ids
- use data source to filter ami id of ubuntu
- use data source to filter all azs
- create sg for ALB to allow 80 port
- create sg for ec2 web server instances to allow 8080 from alb, allow 22 for ssh
- create launch template with specfied instance type, ami id, user_data (install ansible and call ansible playbook)
- create alb with newly created sg and subnets
- create target group with port 8080
- create asg with launch template, size, target group arn, vpc zone
- create ALB listener and create rule to forward traffic to target group

### Demo

![Terraform task Demo](https://raw.githubusercontent.com/akilans/terraform-task/main/terraform-task.gif)
