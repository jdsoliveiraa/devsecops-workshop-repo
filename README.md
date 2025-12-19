# DevSecOps Workshop - IaC Security

**João Oliveira - 2022184283 - uc2022184283@student.uc.pt**
Cybersecurity Laboratory - Master in Informatics Engineering
Faculty of Sciences and Technologies - University of Coimbra
December 2025

---

Intentionally vulnerable Terraform code for GCP. Learn to identify and fix security issues using automated scanning tools. To be used for the workshop along with the guide.

## Quick Start

```bash
# Scan for vulnerabilities
trivy config terraform
checkov -d terraform

# Apply fixes
git apply patches/fix.patch

# Verify
trivy config terraform
```

## Tools

- **Trivy** - IaC security scanner
- **Checkov** - Policy-as-code
- **Gitleaks** - Secret detection

**DO NOT deploy to production - educational purposes only.**
