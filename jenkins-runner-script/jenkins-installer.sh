#!/usr/bin/env bash
set -euo pipefail

# Supports Debian/Ubuntu hosts. Run as root or with sudo access.
run_as_root() {
  if [[ "${EUID}" -eq 0 ]]; then
    "$@"
  else
    sudo "$@"
  fi
}

TERRAFORM_VERSION="${TERRAFORM_VERSION:-1.6.5}"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

case "$(uname -m)" in
  x86_64)
    TERRAFORM_ARCH="amd64"
    ;;
  aarch64|arm64)
    TERRAFORM_ARCH="arm64"
    ;;
  *)
    echo "Unsupported CPU architecture: $(uname -m)" >&2
    exit 1
    ;;
esac

run_as_root apt-get update
run_as_root env DEBIAN_FRONTEND=noninteractive apt-get install -y \
  ca-certificates curl gnupg openjdk-17-jre-headless unzip

# Add the official Jenkins stable repository using its signing key.
run_as_root install -d -m 0755 /etc/apt/keyrings
run_as_root curl -fsSL \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key \
  -o /etc/apt/keyrings/jenkins-keyring.asc
printf '%s\n' \
  'deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/' \
  | run_as_root tee /etc/apt/sources.list.d/jenkins.list >/dev/null

run_as_root apt-get update
run_as_root env DEBIAN_FRONTEND=noninteractive apt-get install -y jenkins
run_as_root systemctl enable --now jenkins

# Download a pinned Terraform release for the host architecture and verify its checksum.
TERRAFORM_ZIP="terraform_${TERRAFORM_VERSION}_linux_${TERRAFORM_ARCH}.zip"
BASE_URL="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}"
curl -fsSL "${BASE_URL}/${TERRAFORM_ZIP}" -o "${TMP_DIR}/${TERRAFORM_ZIP}"
curl -fsSL "${BASE_URL}/terraform_${TERRAFORM_VERSION}_SHA256SUMS" -o "${TMP_DIR}/SHA256SUMS"
(
  cd "${TMP_DIR}"
  grep " ${TERRAFORM_ZIP}$" SHA256SUMS | sha256sum --check -
)
unzip -q "${TMP_DIR}/${TERRAFORM_ZIP}" -d "${TMP_DIR}"
run_as_root install -m 0755 "${TMP_DIR}/terraform" /usr/local/bin/terraform

terraform version
systemctl is-active --quiet jenkins
echo "Jenkins and Terraform installation completed."
