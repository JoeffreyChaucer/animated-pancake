#!/bin/bash
set -euo pipefail

install_sfdx_plugins() {
    echo "--- Installing sfdx plugins"
    echo "Installing @dxatscale/sfpowescipts..."
}

authenticate_to_sandbox() {
    echo "--- Authenticating to $1"
}

tempoary_file(){
    local branch
    local version
    branch=$(buildkite-agent meta-data get "branch-release-stream")
    version=$(buildkite-agent meta-data get "release-version")
    git fetch
    git show origin/$branch:release-docs-$version.sh
}


deploy_elease_to_sandbox(){
    echo "--- Release to $1"
    echo "release-docs-$version"
}


main() {
    install_sfdx_plugins
    authenticate_to_sandbox "$1"
    tempoary_file
    deploy_elease_to_sandbox "$1"
    trap 'release-docs-$version' EXIT

}

main "$1"