#!/bin/bash
#set -euo pipefail

release=""

if [ ! -z "$TRAVIS_TAG" ]; then
    release=$TRAVIS_TAG
fi

if [ -z "$release" ] && [ ! -z "$TRAVIS_BRANCH" ]; then
    release="${TRAVIS_BRANCH}-${TRAVIS_COMMIT}"
fi

if [ -z "$release" ]; then
    echo "Could not determine branch or tag."
    exit 1
fi

repo=`dirname ${TRAVIS_REPO_SLUG}`

mkdir -p s3-upload/
zip -r s3-upload/$repo-$release.zip ./dist
