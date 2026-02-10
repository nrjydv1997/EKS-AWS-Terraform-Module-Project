# EKS-AWS-Terraform-Module-Project

# Amazon EKS Terraform Modular Infrastructure

## Overview

This project provisions a **production-style Amazon EKS environment using Terraform modules**.
It demonstrates how to design and deploy Kubernetes infrastructure on AWS using Infrastructure as Code with proper IAM separation, IRSA configuration, and Helm-based platform components.

The goal of this project is to understand:

* EKS architecture
* Terraform module design
* IAM and IRSA integration
* Kubernetes platform deployment with Helm
* Bastion-based cluster access
* Monitoring stack deployment

---

## Architecture

Infrastructure provisioning flow:

```
VPC → IAM Core → EKS Cluster → OIDC Provider → IRSA → Bastion → Helm Platform
```

---

## Components

### Networking (VPC Module)

Creates:

* VPC
* Public subnets
* Private subnets
* Internet Gateway
* NAT Gateway
* Route tables

---

### Security Groups

Creates:

* Bastion security group
* EKS cluster security group

---

### IAM Core Module

Creates IAM resources required before cluster creation:

* EKS cluster role
* Nodegroup role
* Bastion role
* Bastion instance profile

---

### EKS Module

Creates:

* EKS cluster
* Managed node groups

  * On-Demand nodes
  * Spot nodes
* OIDC provider
* EKS addons:

  * VPC CNI
  * CoreDNS
  * kube-proxy
  * EBS CSI Driver
  * EFS CSI Driver

---

### IAM IRSA Module

Creates IAM roles for Kubernetes service accounts:

* ALB Controller IAM role
* OIDC trust policy
* IRSA policies

Uses:

```
sts:AssumeRoleWithWebIdentity
```

---

### Bastion Module

Creates:

* EC2 bastion instance
* IAM instance profile
* kubectl installation
* AWS CLI installation
* eksctl installation
* Helm installation

This allows secure cluster access from inside the VPC.

---

### Helm Module

Deploys Kubernetes platform components:

* AWS Load Balancer Controller
* Prometheus (kube-prometheus-stack)
* Grafana
* ArgoCD

All deployments use Terraform Helm provider.

---

## Project Structure

```
modules/
├── vpc
├── sg
├── iam_core
├── eks
├── iam_irsa
├── bastion
└── helm
```

Root files:

```
main.tf
provider.tf
variables.tf
outputs.tf
dev.tfvars
bastion_script.sh
```

---

## Prerequisites

Install:

* Terraform ≥ 1.5
* AWS CLI v2
* kubectl
* Helm
* eksctl

AWS account with permissions to create:

* IAM
* VPC
* EKS
* EC2

---

## AWS CLI Configuration

Terraform Kubernetes provider requires JSON output.

Set once:

```
export AWS_PAGER=""
export AWS_DEFAULT_OUTPUT=json
```

Or configure:

```
~/.aws/config
```

```
[default]
output = json
```

---

## Initialize Terraform

```
terraform init
```

---

## Apply Infrastructure

```
terraform apply -var-file=dev.tfvars
```

---

## Configure kubeconfig

```
aws eks update-kubeconfig --region ap-south-1 --name <cluster-name>
kubectl get nodes
```

---

## Access Services

After deployment:

```
kubectl get svc -A
```

Look for LoadBalancer services:

* Grafana
* Prometheus
* ArgoCD

---

## Key Concepts Demonstrated

* Terraform module design
* EKS provisioning from scratch
* Managed node groups
* IAM Roles for Service Accounts (IRSA)
* OIDC provider integration
* Helm deployment using Terraform
* Bastion host access pattern
* Monitoring stack deployment

---

## Learning Outcome

This project demonstrates how to build and manage a Kubernetes platform on AWS using Terraform with a modular and production-style approach.

It covers both infrastructure provisioning and Kubernetes platform deployment in a single reproducible workflow.

---

## Author

DevOps learning project focused on Kubernetes, AWS, and Infrastructure as Code.
