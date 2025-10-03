# 🌐 VPN Infrastructure with Terraform, Docker & Kubernetes

## 📖 Overview
This project provisions a **secure VPN service** in AWS using **Infrastructure-as-Code** with Terraform, containerization with Docker, and orchestration with Kubernetes (EKS).  
It demonstrates **DevOps/SRE skills** in infrastructure automation, cloud networking, observability, and clean developer workflows.

**Key features:**
- Automated AWS VPC + compute resources via Terraform  
- VPN service (WireGuard/OpenVPN) packaged in Docker  
- Kubernetes (EKS) deployment for scalability & resilience  
- Monitoring with Prometheus & Grafana  
- Optional FastAPI backend + React frontend for managing VPN clients and viewing metrics  

---

## 🏗️ Architecture
See [ARCHITECTURE.md](docs/ARCHITECTURE.md) for detailed design.

High-level flow:
1. Terraform → provisions AWS infra (VPC, EC2/EKS, security groups)  
2. VPN container → deployed on EC2 or as pods in EKS  
3. Clients → connect securely via VPN tunnel  
4. Monitoring + UI → optional layer for observability & management  

---

## 🚀 Getting Started

### Prerequisites
- WSL or Linux environment
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [AWS CLI](https://docs.aws.amazon.com/cli/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)  
- [Docker](https://www.docker.com/)  
- (Optional) [Helm](https://helm.sh/)  

### Setup
1. Clone the repo:
   ```bash
   git clone git@github.com:lupenox/vpn-terraform-k8s.git
   cd vpn-terraform-k8s
Initialize Terraform:

bash
Copy code
cd terraform
terraform init
terraform plan
terraform apply
Connect to your VPN:

Terraform outputs connection details + client config

Import into your WireGuard/OpenVPN client

📂 Repository Structure
graphql
Copy code
vpn-terraform-k8s/
├─ terraform/          # IaC for AWS infra
├─ docker/             # Dockerfile for VPN container
├─ k8s/                # Kubernetes manifests
├─ scripts/            # Provisioning helpers
├─ ui/                 # FastAPI + React (optional)
├─ docs/               # ARCHITECTURE.md, diagrams, setup notes
└─ README.md
🛡️ Security Considerations
WireGuard (preferred) or hardened OpenVPN config

IAM least privilege roles

TLS for UI/API via cert-manager

Secrets stored in AWS Secrets Manager / K8s Secrets

Terraform state stored remotely (S3 + DynamoDB lock recommended)

🔮 Roadmap
 Add GitHub Actions CI/CD

 Expand FastAPI backend for VPN client management

 Build React UI for observability & Grafana integration

 Add multi-region deployment with Terraform workspaces

🤖 AI Workflow
This project was built using a hybrid workflow of human design + AI assistance:

ChatGPT (GPT-5) → architecture design, implementation planning, debugging

Phind → fast syntax & CLI checks

Perplexity → quick research and docs lookups

📜 License
MIT License – open for learning & extension.