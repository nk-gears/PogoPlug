#!/bin/bash
HOSTNAME=
API=

echo url="https://www.duckdns.org/update?domains=\"$HOSTNAME\"&token=\"$API\"&ip=" | curl -k -o /home/pogoplug/applications/duckdns/duckdns.log -K -