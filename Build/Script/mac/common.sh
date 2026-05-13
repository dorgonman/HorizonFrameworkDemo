#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# Thin wrapper — delegates to Build/Base/Script/mac/common-remote.sh
# Product-specific policy (KANOBUILD_MAC_REMOTE_* overrides) stays here.
# =============================================================================

# Source the shared implementation first.
# This file lives at Build/Script/mac/common.sh
# common-remote.sh lives at Build/Base/Script/mac/common-remote.sh
# Relative path from Build/Script/mac/: ../../Base/Script/mac/common-remote.sh
_source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "${_source_dir}/../../Base/Script/mac/common-remote.sh"
unset _source_dir

# Determine the repo root from THIS script's location (always correct: BASH_SOURCE[0] == this file)
horizon_mac_remote_project_root() {
    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    (cd "${script_dir}/../../.." && pwd)
}

# Pass-through wrappers — base layer owns the implementation
horizon_mac_shell_quote()          { horizon_base_shell_quote "$@"; }
horizon_mac_remote_host()          { horizon_base_remote_host "$@"; }
horizon_mac_remote_root()          { horizon_base_remote_root "$@"; }
horizon_mac_remote_engine_root()   { horizon_base_remote_engine_root "$@"; }
horizon_mac_rsync_project()        { horizon_base_rsync_project "$@"; }
horizon_mac_run_remote_command()   { horizon_base_run_remote_command "$@"; }
horizon_mac_remote_build()         { horizon_base_remote_build "$@"; }
