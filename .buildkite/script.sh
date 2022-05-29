#!/bin/bash
set -euo pipefail


echo $BUILDKITE_COMMIT


git diff --stat HEAD


if ! git diff --name-only HEAD | grep -qvE '(.md)'
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
