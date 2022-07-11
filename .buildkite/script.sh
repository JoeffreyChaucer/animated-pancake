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
    git fetch
    git show origin/"$BRANCH":.buildkite/release-docs-"$VERSION".sh > release-docs-"$VERSION".sh
}


deploy_release_to_sandbox(){
    echo "--- Release to $1"
    echo "release-docs-${VERSION}"
}

cleanup_temporary_file() {
    trap release-docs-"$VERSION".sh EXIT
}


main() {
    local VERSION
    local BRANCH
    local SANDBOX_NAME="$1"
    VERSION=$(buildkite-agent meta-data get "release-version")
    BRANCH=$(buildkite-agent meta-data get "branch-release-stream")


    install_sfdx_plugins
    authenticate_to_sandbox "$SANDBOX_NAME"
    temporary_file "$SANDBOX_NAME"
    deploy_release_to_sandbox "$SANDBOX_NAME"
    cleanup_temporary_file
}

main "$1"