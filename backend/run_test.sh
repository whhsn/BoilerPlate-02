#!/bin/bash
if [ -z "$1" ]; then
  echo "Usage: $0 <module>"
  exit 1
fi
pytest $1 --cov=$1
