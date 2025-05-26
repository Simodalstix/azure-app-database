# Azure App + Database Infrastructure

This project sets up a secure, modular Azure infrastructure to support a web application with a managed PostgreSQL database. It uses Terraform to provision isolated dev and prod environments and supports scalable deployments, CI/CD integration, and strong access control.

## Purpose

I created this project to deepen my understanding of production-grade Azure infrastructure, particularly how to separate environments, apply security best practices, and manage cloud resources through code. It reflects my goal of becoming fluent in infrastructure-as-code and platform engineering principles using real-world tools.

## Architecture Overview

The infrastructure includes:

- Virtual Network (VNet) with address space isolation for dev and prod
- Subnets with Network Security Groups
- Azure App Service for containerized web apps
- Azure Database for PostgreSQL
- Storage Account for Terraform state (in a separate backend)
- Key Vault for secrets (planned)
- GitHub Actions for CI/CD (planned)

## Repository Structure

```
azure-app-database/
├── environments/
│   ├── dev/
│   │   └── main.tf
│   └── prod/
│       └── main.tf
├── modules/
│   ├── vnet/
│   ├── app_service/
│   └── postgres/
└── backend/
    └── storage.tf
```

- `environments/` contains isolated configurations for dev and prod.
- `modules/` contains reusable components (VNet, App Service, DB).
- `backend/` defines remote state storage for Terraform.

## Tools Used

- Terraform
- Azure CLI & Portal
- GitHub Actions (CI/CD pipeline planned)
- Linux CLI (WSL)
- Visual Studio Code

## Key Features

- Clean separation between dev and prod
- Reusable infrastructure modules
- State managed remotely with secure storage
- Prepared for CI/CD and secret injection workflows

## In Progress / Next Steps

- Integrate GitHub Actions workflows for deployment
- Add Key Vault + role-based access control to modules
- Set up monitoring with Azure Monitor + Log Analytics
- Include application layer deployment + container integration
- Add Helm/AKS deployment pathway for future projects

## About

This repository is part of my personal journey into professional platform engineering. I'm using it to showcase practical skills in Azure infrastructure, and to support my career transition from support and pharmacy into DevOps and cloud engineering roles.
