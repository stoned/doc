#!/bin/bash -
set -ex
set -o pipefail

: ${TEST_IMAGE:=docker.io/jjmerelo/perl6-doccer:latest}
: ${P6_DOC_TEST_VERBOSE:=1}

# this default value allows one to run a command like
# ./util/github-action-test.sh
: ${GITHUB_WORKSPACE:=${PWD}}

printenv | sort

# if no argument is given run tests from t/
if [[ $# -eq 0 ]]; then
  set -- t
fi

docker run -t \
  -v "${GITHUB_WORKSPACE}":/test:Z \
  --entrypoint env \
  "${TEST_IMAGE}" \
  P6_DOC_TEST_VERBOSE=${P6_DOC_TEST_VERBOSE} \
  prove6 "$@"

# vim: ts=2 sts=2 sw=2 expandtab ft=sh:
