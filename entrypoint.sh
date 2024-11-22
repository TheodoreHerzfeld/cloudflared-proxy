#!/bin/bash

echo "Starting cloudflared in Docker"

if [ -f /etc/cloudflared/config.yml ]; then
    echo "Found existing configuration! Running cloudlfared..."
    cloudflared
else
    echo "Detected new installation...copying required config files"
    cp /default/config.yml /etc/cloudflared
    echo "Done - starting cloudflared"
    cloudflared proxy-dns --port 5053
fi
