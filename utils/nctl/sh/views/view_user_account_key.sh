#!/usr/bin/env bash
#
# Renders a user account key.
# Globals:
#   NCTL - path to nctl home directory.
# Arguments:
#   Network ordinal identifier.
#   User ordinal identifier.

#######################################
# Destructure input args.
#######################################

# Unset to avoid parameter collisions.
unset net
unset user

for ARGUMENT in "$@"
do
    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)
    case "$KEY" in
        net) net=${VALUE} ;;
        user) user=${VALUE} ;;
        *)
    esac
done

# Set defaults.
net=${net:-1}
user=${user:-"all"}

#######################################
# Main
#######################################

# Import utils.
source $NCTL/sh/utils.sh

# Import net vars.
source $(get_path_to_net_vars $net)

# Render account key(s).
if [ $user = "all" ]; then
    for IDX in $(seq 1 $NCTL_NET_USER_COUNT)
    do
        render_account_key $net $NCTL_ACCOUNT_TYPE_USER $IDX
    done
else
    render_account_key $net $NCTL_ACCOUNT_TYPE_USER $user
fi
