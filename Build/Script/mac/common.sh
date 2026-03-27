#!/usr/bin/env bash
# HorizonFrameworkDemo - Windows->SSH Mac remote build helpers
set -euo pipefail

horizon_mac_remote_project_root() {
    (cd "${BASH_SOURCE[0]%/*}/../../.." && pwd)
}

horizon_mac_remote_host() {
    printf '%s\n' "${KANOBUILD_MAC_REMOTE_HOST:-dorgon.chang@macbuilder.cobia-tailor.ts.net}"
}

horizon_mac_remote_root() {
    printf '%s\n' "${KANOBUILD_MAC_REMOTE_ROOT:-/tmp/HorizonFrameworkDemo}"
}

horizon_mac_remote_engine_root() {
    printf '%s\n' "${KANOBUILD_MAC_REMOTE_ENGINE_ROOT:-/Users/dorgon.chang/EpicGames/UE_5.7}"
}

horizon_mac_shell_quote() {
    MSYS_NO_PATHCONV=1 VALUE="${1}" python - <<'PY'
import os, shlex
print(shlex.quote(os.environ["VALUE"]))
PY
}

horizon_mac_rsync_project() {
    local project_root remote_host remote_root
    project_root="${1}"; remote_host="${2}"; remote_root="${3}"
    local rsync_args=(
        -az --delete --mkpath
        --exclude=.git/ --exclude=.vs/
        --exclude=Binaries/ --exclude=DerivedDataCache/
        --exclude=Intermediate/ --exclude=Saved/
        --exclude=Plugins/VisualStudioTools/
        --exclude=ue_ci_scripts/ --exclude=horizon_ci_scripts/
    )
    if [[ "${KANOBUILD_DRY_RUN:-}" == "1" ]]; then
        printf 'DRY RUN RSYNC: rsync %q %q %q\n' "${rsync_args[@]}" "${project_root}/" "${remote_host}:${remote_root}/"
        return 0
    fi
    rsync "${rsync_args[@]}" "${project_root}/" "${remote_host}:${remote_root}/"
}

horizon_mac_run_remote_command() {
    local remote_host remote_root remote_engine_root script_path
    remote_host="${1}"; remote_root="${2}"; remote_engine_root="${3}"; script_path="${4}"
    shift 4
    local remote_args=""
    if (($# > 0)); then
        remote_args=" $(python - "$@" <<'PY'
import shlex, sys
print(' '.join(shlex.quote(a) for a in sys.argv[1:]))
PY
)"
    fi
    local remote_cmd="export UNREAL_ENGINE_ROOT=$(horizon_mac_shell_quote "${remote_engine_root}"); cd $(horizon_mac_shell_quote "${remote_root}") && bash $(horizon_mac_shell_quote "${script_path}")${remote_args}"
    if [[ "${KANOBUILD_DRY_RUN:-}" == "1" ]]; then
        printf 'DRY RUN SSH: ssh %q %q\n' "${remote_host}" "${remote_cmd}"
        return 0
    fi
    ssh "${remote_host}" "${remote_cmd}"
}

horizon_mac_remote_build() {
    local script_path project_root remote_host remote_root remote_engine_root
    script_path="${1}"; shift
    project_root="$(horizon_mac_remote_project_root)"
    remote_host="$(horizon_mac_remote_host)"
    remote_root="$(horizon_mac_remote_root)"
    remote_engine_root="$(horizon_mac_remote_engine_root)"
    if ! command -v rsync >/dev/null 2>&1; then
        echo "rsync not found in PATH." >&2; return 1
    fi
    if ! command -v ssh >/dev/null 2>&1; then
        echo "ssh not found in PATH." >&2; return 1
    fi
    horizon_mac_rsync_project "${project_root}" "${remote_host}" "${remote_root}"
    horizon_mac_run_remote_command "${remote_host}" "${remote_root}" "${remote_engine_root}" "${script_path}" "$@"
}
