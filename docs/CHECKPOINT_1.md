# Project Checkpoint – Terraform VPN MVP

**Date:** 2025-10-03  
**Status:** ✅ Infrastructure working, EC2 deployed, SSH verified.

---

## What’s Done
- [x] Terraform project initialized (`terraform init`, `terraform plan`, `terraform apply`)
- [x] AWS VPC, Subnet, Internet Gateway, Route Table created
- [x] Security Group allows SSH (22/tcp) + WireGuard (51820/udp)
- [x] EC2 instance (Ubuntu 22.04, t3.micro) deployed
- [x] `install_vpn.sh` ran successfully via `user_data`
- [x] Verified `wireguard` + `qrencode` installed
- [x] IP forwarding enabled
- [x] SSH login successful with key pair (`logan-key.pem`)

---

## Commands Recap

### Deploy
```bash
cd ~/projects/vpn-terraform-k8s/terraform
terraform init
terraform plan
terraform apply
Destroy
bash
Copy code
terraform destroy
SSH
bash
Copy code
ssh -i ~/.ssh/logan-key.pem ubuntu@<vpn_server_ip>
Replace <vpn_server_ip> with output from:

bash
Copy code
terraform output vpn_server_ip
Next Steps (Future Logan 💡)
Configure WireGuard server (/etc/wireguard/wg0.conf)

Add a client peer + generate QR code for mobile import

Test tunnel connectivity

Automate WireGuard setup with systemd service

Consider Terraform modules for cleaner structure

Notes
EC2 Region: us-east-2 (Ohio)

AMI used: ami-0fb653ca2d3203ac1

Key pair name: logan-key (stored safely in ~/.ssh/logan-key.pem, not committed to git)

Billing caution: destroy resources when idle to avoid charges