#!/bin/bash

# https://github.com/chmln/sd

cp orig.txt file.txt

sd \
  "INSERT INTO \"auth\"\.\"audit_log_entries\"[^;]*;" "" \
  file.txt

