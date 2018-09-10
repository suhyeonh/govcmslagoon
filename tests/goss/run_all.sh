#!/usr/bin/env bash
##
# Run all GOSS tests.
#

TEST_DIR=${TEST_DIR:-tests/goss}

fails=0
for file in $TEST_DIR/*.yaml; do
  prefix=$TEST_DIR/goss.
  service=${file/$prefix/}
  service=${service/.yaml/}
  echo "==> Running tests for \"$service\" service"
  goss -g $file render > goss.yaml && dgoss run -i govcmslagoon/$service:latest || ((fails++))
  rm -Rf goss.yaml
  echo "==> Finished tests for \"$service\" service"
done

exit $fails
