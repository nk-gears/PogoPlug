#!/bin/bash

API=<API>
TITLE="$1"
MSG="$2"

curl -u $API: https://api.pushbullet.com/v2/pushes -d type=note -d title="$TITLE" -d body="$MSG"