\# 🚀 Terraform AWS Infrastructure Portfolio



A collection of hands-on Terraform projects demonstrating AWS infrastructure provisioning, automation, networking, security, compute, storage, databases, and advanced Infrastructure as Code practices.



\---



\## 🛠️ Technologies Used



\* Terraform

\* AWS

\* Amazon EC2

\* Amazon VPC

\* Amazon S3

\* Amazon RDS

\* IAM

\* Application Load Balancer

\* AWS Lambda

\* ElastiCache

\* Git \& GitHub



\---



\## 📂 Projects



\### 🚀 Terraform Provisioner



Automated AWS infrastructure deployment using Terraform provisioners.



\*\*Includes:\*\*



\* Custom VPC

\* Public Subnet

\* Internet Gateway

\* Route Table

\* Security Group

\* EC2 Instance

\* File Provisioner

\* Remote-Exec Provisioner

\* Apache Web Server

\* Automated HTML deployment



📁 Project folder:



```text

terraform-provisioner/

```



\---



\### 🌐 Terraform VPC



AWS VPC networking infrastructure using Terraform.



\---



\### 🖥️ Terraform Private EC2



Private EC2 infrastructure deployment.



\---



\### ⚖️ Terraform ALB



Application Load Balancer infrastructure with EC2 instances.



\---



\### 🔐 Terraform IAM



AWS IAM users, roles, and permissions using Infrastructure as Code.



\---



\### 🗄️ Terraform RDS \& ElastiCache



Database infrastructure using:



\* Amazon RDS

\* ElastiCache



\---



\### 📦 Terraform S3 Backend



Remote Terraform state management and state locking concepts.



\---



\### ⚡ Terraform Lambda + S3



Serverless AWS architecture using:



\* AWS Lambda

\* Amazon S3



\---



\### 🧩 Terraform Modules



Reusable Terraform modules for:



\* VPC

\* EC2

\* RDS



\---



\## 🚀 Terraform Workflow



```text

Write Terraform Code

&#x20;       ↓

terraform init

&#x20;       ↓

terraform validate

&#x20;       ↓

terraform plan

&#x20;       ↓

terraform apply

&#x20;       ↓

AWS Infrastructure Deployed

```



\---



\## 🔧 Common Terraform Commands



```bash

terraform init

terraform validate

terraform fmt

terraform plan

terraform apply

terraform destroy

```



\---



\## 🌍 Terraform Provisioner Architecture



```text

Terraform

&#x20;   │

&#x20;   ▼

AWS VPC

&#x20;   │

&#x20;   ▼

Public Subnet

&#x20;   │

&#x20;   ▼

Internet Gateway

&#x20;   │

&#x20;   ▼

Route Table

&#x20;   │

&#x20;   ▼

Security Group

&#x20;   │

&#x20;   ▼

EC2 Instance

&#x20;   │

&#x20;   ├── File Provisioner

&#x20;   │       │

&#x20;   │       └── index.html → /tmp/index.html

&#x20;   │

&#x20;   └── Remote-Exec Provisioner

&#x20;           │

&#x20;           ├── Install Apache

&#x20;           ├── Start Apache

&#x20;           └── Deploy Website

```



\---



\## 🔐 Security



Sensitive files are excluded using `.gitignore`.



Never commit:



```text

\*.pem

terraform.tfstate

terraform.tfstate.\*

.terraform/

```



\---



\## 📚 Learning Goals



This portfolio demonstrates practical experience with:



\* Infrastructure as Code

\* AWS Cloud Infrastructure

\* Terraform Resource Management

\* Terraform Provisioners

\* VPC Networking

\* EC2 Deployment

\* IAM

\* Load Balancing

\* Database Infrastructure

\* Terraform Modules

\* Remote State Management

\* Serverless Architecture



\---



\## 👨‍💻 Author



\*\*Firoz Lonare\*\*



GitHub: \[firoz-lonare-official](https://github.com/firoz-lonare-official)



\---



⭐ If you find this repository useful, feel free to star the repository!



