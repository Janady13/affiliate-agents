#!/bin/bash

# Affiliate Agents - Agent Generator Script
# Generates new agent folders with HTML pages and placeholder QR codes

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Banner
echo "=================================================="
echo "  Affiliate Agents - Generator"
echo "=================================================="
echo ""

# Check arguments
if [ $# -ne 2 ]; then
    log_error "Usage: $0 <start_number> <end_number>"
    echo "Example: $0 5001 5100"
    exit 1
fi

START=$1
END=$2

# Validate input
if ! [[ "$START" =~ ^[0-9]+$ ]] || ! [[ "$END" =~ ^[0-9]+$ ]]; then
    log_error "Both arguments must be numbers"
    exit 1
fi

if [ $START -gt $END ]; then
    log_error "Start number must be less than or equal to end number"
    exit 1
fi

COUNT=$((END - START + 1))

echo "Generating $COUNT agents (AGENT$START to AGENT$END)"
echo ""

# Confirm
read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log_info "Cancelled by user"
    exit 0
fi

log_info "Starting generation..."
echo ""

CREATED=0
SKIPPED=0

for i in $(seq $START $END); do
    AGENT_ID="AGENT$i"
    AGENT_DIR="$AGENT_ID"

    # Check if directory already exists
    if [ -d "$AGENT_DIR" ]; then
        log_info "Skipping $AGENT_ID (already exists)"
        SKIPPED=$((SKIPPED + 1))
        continue
    fi

    # Create directory
    mkdir -p "$AGENT_DIR"

    # Create index.html
    cat > "$AGENT_DIR/index.html" << EOF
<!doctype html>
<html lang="en">
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Affiliate Offer - $AGENT_ID</title>
<body style="font-family: system-ui,-apple-system,Segoe UI,Roboto,Ubuntu;">
  <h1>Affiliate Offer - $AGENT_ID</h1>
  <a href="https://example.com/offer?sid=$AGENT_ID" target="_blank" rel="noopener noreferrer">Affiliate Offer</a>
  <img src="https://example.com/offer?sid=$AGENT_ID" width="1" height="1" style="border:0" alt="" /><br>
  <img src="qr.png" width="150" alt="$AGENT_ID QR" />
</body>
</html>
EOF

    # Create placeholder QR code (1x1 transparent PNG)
    # This is a base64 encoded 1x1 transparent PNG
    echo "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==" | base64 -d > "$AGENT_DIR/qr.png"

    CREATED=$((CREATED + 1))

    # Progress indicator
    if [ $((CREATED % 10)) -eq 0 ]; then
        echo -n "."
    fi
done

echo ""
echo ""
log_success "Generation complete!"
echo ""
echo "Summary:"
echo "  - Created: $CREATED agents"
echo "  - Skipped: $SKIPPED agents"
echo "  - Total:   $COUNT agents processed"
echo ""

log_info "Next steps:"
echo "1. Replace placeholder QR codes with actual QR codes"
echo "2. Update affiliate URLs in HTML files"
echo "3. Test locally: python3 -m http.server 8000"
echo "4. Commit and push to GitHub"
echo ""

log_info "To update all affiliate URLs at once, you can use:"
echo "  find . -name 'index.html' -exec sed -i 's|https://example.com|YOUR_AFFILIATE_URL|g' {} +"
echo ""

log_success "Done! ✓"
