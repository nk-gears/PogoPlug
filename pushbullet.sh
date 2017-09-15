#!/bin/bash

API=o.xYd9Q85uxflrzlSXukayL0XFiYfSfdqf
TITLE="$1"
MSG="$2"

curl -u $API: https://api.pushbullet.com/v2/pushes -d type=note -d title="$TITLE" -d body="$MSG"