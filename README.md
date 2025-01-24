AWS Infrastructure Provisioning with Terraform & Ansible

Project Overview
This project automates the provisioning of cloud infrastructure on AWS using *Terraform* and *Ansible*. The resources deployed include EC2 instances, VPC, Subnets, and Security Groups. NGINX is automatically installed and configured on the EC2 instances.

Features
- *Provisioned AWS Infrastructure* using *Terraform* (EC2, VPC, Subnets, Security Groups).
- *Automated NGINX Setup* on EC2 instances with *Ansible*.
- Utilized *SSH Key-based Authentication* for secure communication between instances.
- Managed *Public IPs* for external access to the instances.
- Integrated *Infrastructure as Code (IaC)* to improve deployment efficiency and consistency.

Prerequisites
- AWS account
- Terraform installed
- Ansible installed
- SSH key for EC2 instances

Setup Instructions

1. Clone the repository:
    bash
    git clone <repo-url>
    cd <project-directory>
    

2. Configure AWS CLI:
    bash
    aws configure
    

3. Initialize Terraform and apply the configurations:
    bash
    terraform init
    terraform apply
    ```

4. Once the EC2 instance is up, use the public IP to access the NGINX server in your browser.
