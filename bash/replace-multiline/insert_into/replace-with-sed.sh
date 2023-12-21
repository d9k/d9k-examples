#!/bin/bash

cp orig.txt file.txt

sed \
  --in-place \
  --null-data `# to match newlines symbols` \
  "s|INSERT INTO \"auth\"\.\"audit_log_entries\"[^;]*;||" \
  file.txt

