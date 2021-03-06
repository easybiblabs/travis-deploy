#!/bin/bash
#set -euo pipefail

release=""

if [ ! -z "$TRAVIS_TAG" ]; then
    release=$TRAVIS_TAG
fi

if [ -z "$release" ] && [ ! -z "$TRAVIS_BRANCH" ]; then
    # escape e.g. t/topic so it doesn't look like a folder
    escaped_branch="${TRAVIS_BRANCH//\//-}"
    release="${escaped_branch}-${TRAVIS_COMMIT}"
fi

if [ -z "$release" ]; then
    echo "Could not determine branch or tag."
    exit 1
fi

cd $TRAVIS_BUILD_DIR

repo=`basename ${TRAVIS_REPO_SLUG}`

mkdir -p s3-upload/
zip --quiet -r s3-upload/$repo-$release.zip ${ARTIFACT_FOLDER}
echo "zip for s3 created"
