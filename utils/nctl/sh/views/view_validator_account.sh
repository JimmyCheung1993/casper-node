#!/usr/bin/env bash
#
# Renders a validator account.
# Globals:
#   NCTL - path to nctl home directory.
# Arguments:
#   Network ordinal identifier.
#   Node ordinal identifier.

#######################################
# Destructure input args.
#######################################

# Unset to avoid parameter collisions.
unset net
unset node

for ARGUMENT in "$@"
do
    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)
    case "$KEY" in
        net) net=${VALUE} ;;
        node) node=${VALUE} ;;
        *)
    esac
done

# Set defaults.
net=${net:-1}
node=${node:-"all"}

#######################################
# Main
#######################################

# Import utils.
source $NCTL/sh/utils.sh

# Import net vars.
source $(get_path_to_net_vars $net)

# Render account(s).
if [ $node = "all" ]; then
    for IDX in $(seq 1 $NCTL_NET_NODE_COUNT)
    do
        echo "------------------------------------------------------------------------------------------------------------------------------------"
        log "net-$net :: node #$IDX :: on-chain account details:"
        render_account $net $IDX $NCTL_ACCOUNT_TYPE_NODE $IDX
    done
    echo "------------------------------------------------------------------------------------------------------------------------------------"
else
    log "net-$net :: node #$node :: on-chain account details:"
    render_account $net $node $NCTL_ACCOUNT_TYPE_NODE $node
fi
