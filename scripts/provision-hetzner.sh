#!/usr/bin/env bash
set -euo pipefail

: "${HCLOUD_TOKEN:?Set HCLOUD_TOKEN before running this script}"
: "${SSH_PUBLIC_KEY_PATH:=~/.ssh/id_ed25519.pub}"

SERVER_NAME="${SERVER_NAME:-slokun-prod}"
SERVER_TYPE="${SERVER_TYPE:-cx11}"
LOCATION="${LOCATION:-fsn1}"
IMAGE="${IMAGE:-ubuntu-24.04}"

if ! command -v hcloud >/dev/null 2>&1; then
  echo "hcloud CLI is not installed. Installing it..."
  mkdir -p /tmp/hcloud-install
  cd /tmp/hcloud-install
  curl -fsSL "https://github.com/hetznercloud/cli/releases/latest/download/hcloud-linux-amd64.tar.gz" -o hcloud.tar.gz
  tar -xzf hcloud.tar.gz
  install -m 0755 hcloud /usr/local/bin/hcloud
fi

if [ ! -f "${SSH_PUBLIC_KEY_PATH}" ]; then
  ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519
fi

hcloud context create slokun --token "$HCLOUD_TOKEN" >/dev/null 2>&1 || true
hcloud context switch slokun >/dev/null 2>&1 || true

SSH_KEY_NAME="slokun-ops"
hcloud ssh-key create --name "$SSH_KEY_NAME" --public-key "$(cat "${SSH_PUBLIC_KEY_PATH}")" >/dev/null

SERVER_ID="$(hcloud server create \
  --name "$SERVER_NAME" \
  --type "$SERVER_TYPE" \
  --location "$LOCATION" \
  --image "$IMAGE" \
  --ssh-key "$SSH_KEY_NAME" \
  --format '{{.ID}}')"

SERVER_IP="$(hcloud server describe "$SERVER_ID" --format '{{.PublicNet:IPv4:IP}}')"

echo "Server created: $SERVER_NAME ($SERVER_IP)"

echo "Next steps:"
echo "  1. ssh root@$SERVER_IP"
echo "  2. install Docker + docker compose"
echo "  3. copy .env and docker-compose.yml"
echo "  4. run: docker compose up -d"

echo "Suggested firewall rules (UFW):"
echo "  ufw allow 22/tcp"
echo "  ufw allow 80/tcp"
echo "  ufw allow 443/tcp"
echo "  ufw enable"

echo "Suggested Let's Encrypt setup:"
echo "  apt-get install -y certbot python3-certbot-nginx"
echo "  certbot --nginx -d api.slokun.eu -d business.slokun.eu"
