#!/bin/bash
set -euo pipefail



echo $BUILDKITE_COMMIT
echo $BUILDKITE_PULL_REQUEST_BASE_BRANCH

git diff --stat $BUILDKITE_PULL_REQUEST_BASE_BRANCH...$BUILDKITE_COMMIT



if ! git diff --name-only $BUILDKITE_PULL_REQUEST_BASE_BRANCH...$BUILDKITE_COMMIT | grep -qvE '(.md)'
then
    echo "Only doc files were updated, not running the CI."
    exit 0
fi
