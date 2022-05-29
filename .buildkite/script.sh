#!/bin/bash
set -euo pipefail


echo $BUILDKITE_COMMIT


git diff --stat $BUILDKITE_COMMIT...$BUILDKITE_PULL_REQUEST_BASE_BRANCH


if ! git diff --name-only $BUILDKITE_COMMIT...$BUILDKITE_PULL_REQUEST_BASE_BRANCH | grep -qvE '(.md)'
then
    echo "Only doc files were updated, not running the CI."
    exit
fi


echo "Running pr-validation pipeline."

    buildkite-agent pipeline upload <<YAML
steps:
  - label: "The pr pipeline"
    command: "buildkite-agent pipeline upload .buildkite/pipeline.yml"
YAML
