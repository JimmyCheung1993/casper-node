#!/usr/bin/env bash
#
# Reloads a network node.
# Globals:
#   NCTL - path to nctl home directory.
# Arguments:
#   Network ordinal identifier.
#   Node ordinal identifier.

#######################################
# Destructure input args.
#######################################

# Unset to avoid parameter collisions.
unset NET_ID
unset NODE_ID

for ARGUMENT in "$@"
do
    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)
    case "$KEY" in
        net) NET_ID=${VALUE} ;;
        node) NODE_ID=${VALUE} ;;
        *)
    esac
done

# Set defaults.
NET_ID=${NET_ID:-1}
NODE_ID=${NODE_ID:-"all"}

#######################################
# Main
#######################################

source $NCTL/sh/node/stop.sh net=$NET_ID node=$NODE_ID
source $NCTL/sh/node/start.sh net=$NET_ID node=$NODE_ID
