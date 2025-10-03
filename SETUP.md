# 🛠️ Project Setup Guide

This guide explains how to get back into the project directory and open it in VSCode using WSL.

---

## 1. Open WSL
From Windows (PowerShell or CMD):
```bash
wsl
2. Navigate to the project folder
Inside your WSL terminal:

bash
Copy code
cd ~/projects/vpn-terraform-k8s
3. Open the project in VSCode
bash
Copy code
code .
4. Confirm you are in WSL mode
Look in the bottom-left corner of VSCode.
It should say:

makefile
Copy code
WSL: Ubuntu-24.04
✅ You are now inside the correct project directory:

swift
Copy code
/home/logan/projects/vpn-terraform-k8s
From here you can run:

git add . && git commit -m "message" → to commit changes

git push → to push to GitHub

Terraform, Docker, Kubernetes, etc. commands