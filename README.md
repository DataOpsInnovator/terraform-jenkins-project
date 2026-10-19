# Terraform AWS Infrastructure with a Jenkins Runner

This repository contains a root Terraform configuration and reusable module directories for AWS networking, security groups, a Jenkins EC2 runner, load balancing, Route 53, and ACM certificate resources.

**Important implementation status:** the repository currently contains Terraform modules and a Jenkins installation shell script, but no root Jenkinsfile is present in the source tree. Do not assume that Jenkins CI/CD orchestration is already configured. The Jenkins pipeline should be defined and tested separately before claiming automated execution.

## Repository layout

- `main.tf`, `provider.tf`, `variables.tf`, `outputs.tf`: root Terraform configuration and inputs/outputs.
- `remote_backend_s3.tf`: remote state backend configuration. The backend storage and any locking prerequisites must exist before initialization.
- `networking/`, `security-groups/`: network and security-group modules.
- `jenkins/`: EC2 instance and key-pair resources for the Jenkins runner.
- `load-balancer/`, `load-balancer-target-group/`: load-balancer resources.
- `hosted-zone/`, `certificate-manager/`: Route 53 and ACM resources.
- `jenkins-runner-script/jenkins-installer.sh`: Ubuntu/Debian-oriented Jenkins and Terraform installation helper.

## Prerequisites

- Terraform CLI compatible with the configuration.
- AWS credentials supplied through a supported AWS credential provider or environment, not hard-coded into source.
- Permission to create and manage the resources declared by the configuration.
- A configured AWS region, a reviewed network/security-group design, and any required pre-existing remote-state resources.
- A public SSH key for the EC2 key pair. Never commit the corresponding private key.

## Safe review workflow

From the repository root:

```bash
terraform fmt -check -recursive
terraform init
terraform validate
terraform plan -out=tfplan
terraform show tfplan
```

Review the complete plan, target AWS account/region, public exposure, certificate/DNS dependencies, and estimated charges before applying. Only apply from a trusted environment after explicit approval:

```bash
terraform apply tfplan
```

Do not run apply or destroy as an unreviewed CI step. Keep state files and saved plans private; they can contain sensitive values. Remove local plan files when finished.

## Jenkins runner installer

The installer uses the host architecture to select a Terraform archive, checks the archive against HashiCorp's published SHA-256 checksum list, installs packages non-interactively, and leaves Jenkins service-directory permissions at package defaults. Review the script and pin/update versions according to your maintenance policy before use.

## Security and operational limitations

- The infrastructure can create billable AWS resources and may expose public endpoints depending on input values and security-group configuration.
- Confirm the remote backend is configured and available before running Terraform.
- Review the currently tracked `terraform.tfvars` file before use. Keep environment-specific values and any future sensitive inputs in an untracked local tfvars file or a secrets manager.
- The Jenkins installer is not a substitute for hardening the host, restricting Jenkins network access, configuring authentication, patching plugins, or using least-privilege IAM.
- This README documents the source tree; it does not assert that resources were deployed or that Jenkins was successfully configured in a live AWS account.
