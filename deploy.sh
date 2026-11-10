#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CREDS="$HOME/.shared-ai-memory/credentials.json"

if [ -f "$CREDS" ]; then
  export CLOUDFLARE_API_TOKEN=$(python3 -c "import json; print(json.load(open('$CREDS')).get('cloudflare_api_token',''))")
  export CLOUDFLARE_ACCOUNT_ID=$(python3 -c "import json; print(json.load(open('$CREDS')).get('cloudflare_account_id',''))")
fi

echo "🚀 Deploying Lantern Mech to Cloudflare Pages..."
npx wrangler pages deploy "$SCRIPT_DIR/public" --project-name lantern-mech --branch main
echo "✨ Live Production URL: https://lantern-mech.pages.dev"
