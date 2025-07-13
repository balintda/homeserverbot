#!/usr/bin/env bash
# Usage: telegram-df-ht.sh FilesystemType

output=$(df --output=target,size,used,avail,pcent -Ht $1 | sed 's/Mounted on/Mountpoint/g')

# JSON Escape
json_payload=$(jq -n --arg msg "$output" '{"message": $msg}')

echo $json_payload

# Send it via curl to the telegram bot
curl -X POST http://localhost:5050/send_message_all \
     -H "Content-Type: application/json" \
     -d "$json_payload"
