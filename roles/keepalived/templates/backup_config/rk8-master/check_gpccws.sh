#!/bin/bash
if [ -z "`pidof gpccws`" ]; then
  # systemctl stop keepalived
  exit 1
else
  exit 0
fi
