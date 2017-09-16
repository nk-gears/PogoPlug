#!/bin/bash
HOSTNAME=<HOSTNAME>
API=<APIKEY>

echo url="https://www.duckdns.org/update?domains=\"$HOSTNAME\"&token=\"$API\"&ip=" | curl -k -o /home/pogoplug/applications/duckdns/duckdns.log -K -