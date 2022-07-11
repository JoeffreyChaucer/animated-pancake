#!/bin/bash
set -euo pipefail

install_sfdx_plugins() {
    echo "--- Installing sfdx plugins"
    echo "Installing @dxatscale/sfpowescipts..."
}

authenticate_to_sandbox() {
    echo "--- Authenticating to $1"
}

temporary_file(){
    echo "--- Getting to $1"
    local branch
    local version
    branch=$(buildkite-agent meta-data get "branch-release-stream")
    version=$(buildkite-agent meta-data get "release-version")
    git fetch
    git show origin/"$branch":.buildkite/release-docs-"$version".sh > release-docs-"$version".sh

}


deploy_release_to_sandbox(){
    local version
    echo "--- Release to $1"
    version=$(buildkite-agent meta-data get "release-version")
    echo "release-docs-$version"
}

cleanup_temporary_file() {
    local version
    version=$(buildkite-agent meta-data get "release-version")
    trap 'release-docs-$version' EXIT
}


main() {
    SANDBOX_NAME="$1"
    install_sfdx_plugins
    authenticate_to_sandbox "$SANDBOX_NAME"
    temporary_file "$SANDBOX_NAME"
    deploy_release_to_sandbox "$SANDBOX_NAME"
    cleanup_temporary_file
}

main "$1"