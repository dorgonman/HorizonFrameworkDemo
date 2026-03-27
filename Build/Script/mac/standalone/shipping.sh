#!/usr/bin/env bash
# HorizonFrameworkDemo - macOS standalone (remote build)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/../../../../Build/Base/Script/common.sh"

HOST_PLATFORM="${HOST_PLATFORM:-Mac}"
TARGET_PLATFORM="${TARGET_PLATFORM:-Mac}"
TARGET_CONFIGURATION="${TARGET_CONFIGURATION:-Shipping}"

if [[ "${OSTYPE:-}" == darwin* ]]; then
    build_run_standalone "$@"
else
    source "${SCRIPT_DIR}/../common.sh"
    horizon_mac_remote_build "Build/Script/mac/standalone/shipping.sh" "$@"
fi
