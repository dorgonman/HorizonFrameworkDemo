#!/usr/bin/env bash
# HorizonFrameworkDemo - Build ONLY HorizonFrameworkPlugin for macOS (remote build)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/../../../../Build/Base/Script/common.sh"

HOST_PLATFORM="${HOST_PLATFORM:-Mac}"
TARGET_PLATFORM="${TARGET_PLATFORM:-Mac}"
TARGET_CONFIGURATION="${TARGET_CONFIGURATION:-Shipping}"

build_find_plugins() {
    local project_root="${1:-$(build_project_root)}"
    if [[ -f "${project_root}/Plugins/HorizonFrameworkPlugin/HorizonFrameworkPlugin.uplugin" ]]; then
        printf '%s\n' "${project_root}/Plugins/HorizonFrameworkPlugin/HorizonFrameworkPlugin.uplugin"
    else
        echo "ERROR: HorizonFrameworkPlugin not found at ${project_root}/Plugins/HorizonFrameworkPlugin/HorizonFrameworkPlugin.uplugin" >&2
        return 1
    fi
}

if [[ "${OSTYPE:-}" == darwin* ]]; then
    build_run_plugin "$@"
else
    source "${SCRIPT_DIR}/../common.sh"
    horizon_mac_remote_build "Build/Script/mac/plugin/shipping.sh" "$@"
fi
