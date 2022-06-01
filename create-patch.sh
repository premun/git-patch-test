#!/bin/bash

set -e

sha1=$(cat /work/from_commit)
sha2=$(cat /work/to_commit)

echo "Creating patch.."
cd /work/individual-repo
git diff                                \
    --patch                             \
    -U0                                 \
    --binary                            \
    --output "/work/patch"              \
    --src-prefix=a/src/individual-repo/ \
    --dst-prefix=b/src/individual-repo/ \
    "$sha1..$sha2"                      \
    -- . ":(exclude,glob)**/ignored/**/*"

echo "Patch created:"
cat /work/patch
