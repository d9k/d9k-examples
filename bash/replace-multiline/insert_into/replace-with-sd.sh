#!/bin/bash

cp orig.txt file.txt

sd \
  "INSERT INTO \"auth\"\.\"audit_log_entries\"[^;]*;|" "" \
  file.txt

