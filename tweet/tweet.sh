#!/bin/bash
set -e
source ~/.venv/bin/activate
python -u tweet.py $1
