#!/bin/bash
set -e

TARGET=$1
echo $TARGET
REPORT_DIR="reports"

if [ -z "$TARGET" ]; then
  echo "Usage: ./triage.sh <contract.sol>"
  exit 1
fi

mkdir -p $REPORT_DIR

echo "[*] Running Slither on $TARGET..."
slither $TARGET --print human-summary > $REPORT_DIR/slither_report.txt 2>&1 || true

echo "[*] Running Mythril on $TARGET..."
myth analyze $TARGET > $REPORT_DIR/mythril_report.txt 2>&1 || true

echo "[+] Reports generated in $REPORT_DIR/"

