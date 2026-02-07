# Enterprise CI/CD Pipeline – Jenkins | AWS | Kubernetes

## Overview
This project demonstrates a real-world, enterprise-grade CI/CD pipeline
implemented using Jenkins, Docker, Terraform, and AWS EKS.

The pipeline automates code quality checks, security scanning, container
builds, and Kubernetes deployments following DevSecOps best practices.

This project is based on hands-on experience working with production-like
CI/CD workflows and cloud infrastructure.

## Key Technologies
- GitHub (Source Control)
- Jenkins (CI/CD Automation)
- SonarQube (Code Quality)
- OWASP Dependency Check (Security Scan)
- Docker (Containerization)
- Trivy (Container Vulnerability Scan)
- AWS ECR (Image Registry)
- AWS EKS (Kubernetes)
- Terraform (Infrastructure as Code)

## CI/CD Flow
GitHub → Jenkins → SonarQube → OWASP → Docker → Trivy → ECR → EKS → LoadBalancer

## Highlights
- Multi-stage Jenkins pipeline with quality & security gates
- Infrastructure provisioning using Terraform
- Secure container image scanning before deployment
- Kubernetes deployment with rollback capability
- Production-style pipeline design and troubleshooting

## Note
Sensitive data such as credentials, IPs, and client identifiers
are intentionally masked or excluded.


