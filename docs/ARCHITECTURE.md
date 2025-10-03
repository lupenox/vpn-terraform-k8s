# 🏗️ Architecture — Cloud VPN with Terraform, Docker, Kubernetes & UI

## 1) Overview
This project provisions a **secure VPN service** in the cloud using **Terraform** (IaC), **Docker** (packaging), and **Kubernetes** (orchestration).  
An optional **UI** (FastAPI + React) provides basic admin/observability features.

**Primary goals**
- Reproducible infra (Terraform)  
- Secure, minimal-attack-surface VPN (WireGuard or OpenVPN)  
- Containerized runtime, scalable via Kubernetes  
- Metrics + dashboards (Prometheus/Grafana)  
- Clean operator experience (UI + API)

---

## 2) High-Level Diagram (Conceptual)

+-------------------+ +-------------------------------+
| Client Devices | UDP/TCP| Public Cloud (AWS) |
| (Laptop/Phone) +---------> ┌───────────────────────┐ |
+-------------------+ | │ VPC (Private Network)│ |
| │ ┌─────────────────┐ │ |
| │ │ EKS Cluster │ │ |
| │ │ (Kubernetes) │ │ |
| │ │ ┌───────────┐ │ │ |
| │ │ │ VPN Pods │<-┼─┐ |
| │ │ └───────────┘ │ │ |
| │ │ ┌───────────┐ │ │ |
| │ │ │ UI Pod │ │ │ |
| │ │ └───────────┘ │ │ |
| │ └─────────────────┘ │ |
| │ ┌─────────────────┐ │ |
| │ │ Prometheus/Graf.│ │ |
| │ └─────────────────┘ │ |
| └───────────────────────┘ |
+-------------------------------+

markdown
Copy code

*Variant A (MVP):* Single EC2 instance running VPN (no K8s yet).  
*Variant B (Full):* VPN runs as Kubernetes Deployment on EKS.

---

## 3) Components

### 3.1 Infrastructure (Terraform)
- **Provider**: AWS  
- **Core**: VPC, Subnets, IGW/NAT, Security Groups  
- **Compute**:  
  - *MVP*: EC2 instance (Ubuntu)  
  - *Full*: EKS cluster (managed Kubernetes)  
- **IAM**: least-privilege roles for nodes, CI, and metrics

### 3.2 VPN Service
- **Implementation**: WireGuard *(preferred)* or OpenVPN  
- **Packaging**: Docker image (alpine/ubuntu base)  
- **Config**: server + client keys, allowed IPs, ports  
- **K8s**: Deployment, Service (LoadBalancer), NetworkPolicy

### 3.3 Observability
- **Metrics**: Prometheus (scrape node/app metrics)  
- **Dashboards**: Grafana (connections, throughput, CPU/mem)  
- **Logs**: container logs available via `kubectl logs` / CloudWatch

### 3.4 UI & API (Management)
- **Backend**: FastAPI (Python)  
  - Endpoints: create/list/revoke clients, download configs, read metrics  
- **Frontend**: React (TypeScript)  
  - Pages: Overview (status), Clients, Metrics (Grafana embed or API-fed charts)  
- **Auth**: basic auth/JWT for admin; scope for RBAC later

---

## 4) Security Considerations
- **WireGuard** (modern crypto) or strong OpenVPN config  
- **Security Groups**  
  - Inbound: VPN port (e.g., UDP 51820 for WireGuard), optional SSH (restricted)  
  - Outbound: egress as needed  
- **K8s NetworkPolicy**: restrict pod-to-pod traffic; allow only required flows  
- **Secrets**: never commit keys; use AWS Secrets Manager / K8s Secrets  
- **TLS**: UI/API behind TLS (cert-manager + Let’s Encrypt)  
- **Principle of Least Privilege**: IAM roles scoped to necessity  
- **Key Rotation**: documented process in runbook (below)

---

## 5) Environments
- **Local Dev**: docker-compose or Kind for quick tests of UI/API & VPN image  
- **Cloud Dev**: smaller EKS/EC2 for integration testing  
- **Prod**: EKS (multi-AZ node group), HPA for UI, controlled replicas for VPN

---

## 6) Network & Data Flow

**Client → VPN**
1. Client imports config (wg/openvpn file)  
2. Client connects to VPN Service LB IP/hostname  
3. Pod authenticates keys; encrypted tunnel established

**VPN → Internet/Private**
- Routes client traffic either to the internet via NAT, or to private subnets (split/full tunneling configurable)

**UI/API**
- Frontend (React) → FastAPI (JWT-protected)  
- FastAPI → Kubernetes API / Secrets Manager (user ops)  
- FastAPI → Prometheus (metrics) → displayed in UI

---

## 7) Repository Structure

vpn-terraform-k8s/
├─ terraform/
│ ├─ main.tf # providers, VPC, SGs, EKS or EC2
│ ├─ variables.tf
│ ├─ outputs.tf
│ └─ terraform.tfvars # non-secret defaults
├─ docker/
│ └─ Dockerfile # VPN container
├─ scripts/
│ ├─ install_vpn.sh # EC2 provisioning (MVP path)
│ └─ tooling.sh # helper scripts (optional)
├─ k8s/
│ ├─ deployment.yaml # VPN pods
│ ├─ service.yaml # LoadBalancer service
│ ├─ networkpolicy.yaml
│ └─ helm-chart/ # optional Helm packaging
├─ ui/
│ ├─ api/ # FastAPI backend
│ └─ web/ # React frontend
├─ docs/
│ ├─ ARCHITECTURE.md
│ ├─ SETUP.md
│ └─ architecture-diagram.png
├─ .github/workflows/
│ ├─ ci.yml # lint/test/build
│ └─ deploy.yml # terraform plan/apply, kubectl apply
├─ .gitignore
├─ LICENSE
└─ README.md

pgsql
Copy code

---

## 8) Build & Deploy (Happy Path)

**MVP (few hours):**
1. `terraform apply` → VPC + EC2 + SGs  
2. `install_vpn.sh` via user_data/remote-exec → install & configure WireGuard  
3. `terraform output` prints server IP + client config path  
4. Connect from client and verify tunnel

**Full (Kubernetes):**
1. `terraform apply` → VPC + EKS + node group + SGs  
2. Build & push `docker/Dockerfile` → registry  
3. `kubectl apply -f k8s/` → VPN deployed behind LoadBalancer  
4. Install Prometheus/Grafana (Helm)  
5. UI/API deployed to cluster; cert-manager for TLS

**CI/CD:**
- PR → CI lint/build → Terraform plan comment → on merge → Terraform apply → K8s manifests apply

---

## 9) Operations Runbook (Essentials)
- **Rotate keys**: run admin script or API endpoint to issue/revoke client configs; restart pods if needed  
- **Scale**: edit replicas (K8s), or add node capacity  
- **Patch**: rebuild Docker image (security updates), redeploy via CI  
- **Backup**: persist client keys/configs in encrypted storage; keep IaC state remote backend  
- **Monitoring**: Grafana alerts on CPU, memory, connection count, pod restarts  
- **Incident**: cut traffic with SG, scale to zero, or revoke compromised client keys

---

## 10) Roadmap (Nice-to-Have Enhancements)
- HA for VPN with multiple pods + session-aware LB strategy  
- MFA for UI admin actions  
- Per-client bandwidth quotas / accounting  
- Multi-region deployment via Terraform workspaces/modules  
- Automated key rotation pipeline