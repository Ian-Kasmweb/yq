#!/bin/bash

set -eo pipefail

# You may need to go install github.com/goreleaser/goreleaser/v2@latest first
GORELEASER="goreleaser build --clean"
if [ -z "$CI" ]; then
  GORELEASER+=" --snapshot"
fi

$GORELEASER

cd build

# Remove artifacts from goreleaser
rm artifacts.json config.yaml metadata.json


rhash -r -a . -o checksums

rhash -r -a --bsd . -o checksums-bsd

rhash --list-hashes > checksums_hashes_order

cp ../scripts/extract-checksum.sh .
