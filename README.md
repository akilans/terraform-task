# Terraform Task

- Use Terraform and Ansible to achieve the above

### Requirements

- Create a VPC, use the CIDR of your choice. Also have internet gateway and the required routes
  defined
- Create an auto scaling group
- Create a web server instance
- Change the default web server TCP port from 80 to TCP 8080
- Create a load balancer and point the web server
- Open TCP port 80 on the security group to allow incoming traffic from the world
- Create a IAM user and grant him access to only restart web server
