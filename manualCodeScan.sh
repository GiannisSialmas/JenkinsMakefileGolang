#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
docker run \
    --rm \
    --network="test" \
    -v "$DIR/:/usr/src/" \
    sonarsource/sonar-scanner-cli
