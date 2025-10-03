# Project TODO – VPN Terraform + K8s

**Status:** Work in progress  
**Last updated:** 2025-10-03

---

## Infrastructure
- [ ] Refine Terraform structure (consider using modules for VPC, EC2, SG)
- [ ] Add outputs for subnet ID, SG ID for easier debugging
- [ ] Implement remote state storage (S3 + DynamoDB) instead of local state
- [ ] Add `terraform destroy` safeguards (confirmation script)

---

## VPN Setup
- [ ] Create `/etc/wireguard/wg0.conf` automatically
- [ ] Generate client configs and QR codes for import
- [ ] Test end-to-end VPN tunnel from client → server → internet
- [ ] Add systemd service to auto-start WireGuard at boot
- [ ] Harden iptables rules for security

---

## Kubernetes Integration
- [ ] Define k8s manifests (`deployment.yaml`, `service.yaml`) for VPN or related services
- [ ] Consider Helm chart packaging
- [ ] Explore running VPN pod in k8s cluster instead of raw EC2

---

## UI / Automation
- [ ] Build a simple Python/Flask or Node.js UI to manage configs
- [ ] Upload/download client configs via UI
- [ ] Generate QR codes via UI for quick mobile import
- [ ] Add authentication to UI for security

---

## Documentation
- [ ] Expand `README.md` with setup and usage guide
- [ ] Add architecture diagram (Terraform + EC2 + WireGuard)
- [ ] Keep updating `docs/checkpoint.md` after major milestones
- [ ] Maintain this TODO file as roadmap

---

## Stretch Goals
- [ ] Add monitoring (CloudWatch or Prometheus/Grafana)
- [ ] Add CI/CD pipeline (GitHub Actions) for Terraform validation
- [ ] Try multi-region deployment
- [ ] Package project as a reusable DevOps portfolio showcase
