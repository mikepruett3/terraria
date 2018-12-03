#!/usr/bin/env bash

set -euo pipefail

CMD="./TerrariaServer -x64 -config /app/Worlds/serverconfig.txt"

# Create default config files if they don't exist
if [ ! -f "/app/Worlds/serverconfig.txt" ]; then
    exec ./conf.sh -i
    #exit 1
fi

exec $CMD $@