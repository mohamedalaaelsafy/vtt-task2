#!/bin/bash
DOMAIN=ma-devops.com
RECORD_NAME="python"
GODADDY_API_KEY="gHfBU537MdNg_29ajSzVV7tsi2i8ZwquGme"
GODADDY_API_SECRET="7AsRT1Whp2VhNM8A8HXF1m"

IP=`cat ./scripts/ips.txt`

curl -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H "Authorization: sso-key $GODADDY_API_KEY:$GODADDY_API_SECRET" "https://api.godaddy.com/v1/domains/$DOMAIN/records/A/$RECORD_NAME" -d "[{\"data\": \"$IP\"}]"


