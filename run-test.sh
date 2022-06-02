#!/bin/bash

COLOR_RED=$(tput setaf 1 2>/dev/null || true)
COLOR_CYAN=$(tput setaf 6 2>/dev/null || true)
COLOR_CLEAR=$(tput sgr0 2>/dev/null || true)
COLOR_RESET=uniquesearchablestring

function fail () {
  echo "$FAILURE_PREFIX${COLOR_RED}${1//${COLOR_RESET}/${COLOR_RED}}${COLOR_CLEAR}"
  exit 1
}

function highlight () {
  echo "$FAILURE_PREFIX${COLOR_CYAN}${1//${COLOR_RESET}/${COLOR_CYAN}}${COLOR_CLEAR}"
}

highlight "Individual repo before:"

tree /work/individual-repo

highlight "Individual repo after:"

tree /work/individual-repo

highlight "VMR before:"

tree /work/vmr

set -e

highlight "Creating patch.."

sha1=$(cat /work/from_commit)
sha2=$(cat /work/to_commit)

git -C /work/individual-repo diff         \
    --patch                               \
    -U0                                   \
    --binary                              \
    --output "/work/patch"                \
    --src-prefix=a/src/individual-repo/   \
    --dst-prefix=b/src/individual-repo/   \
    "$sha1..$sha2"                        \
    -- . ":(exclude,glob)**/ignored/**/*" \
    || fail "Failed to create patch"

highlight "Patch created:"
cat /work/patch

highlight "Applying patch.."
git -C /work/vmr apply /work/patch || fail "Applying the patch failed!"
