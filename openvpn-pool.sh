#!/bin/bash

global_configs="${OPENVPN_POOL_GLOBAL_CONFIGS-//;/ /}"
individual_configs="${OPENVPN_POOL_INDIVIDUAL_CONFIGS-//;/ /}"

num_active_connections="0"

function open_connection {
    individual_config="$1"

    ns_name="OPENVPN_POOL_NS_$num_active_connections"

    ip netns add $ns_name

    openvpn $( echo $global_configs | sed -e 's/([a-zA-Z0-9\.\_\-]\+)/--config \1/g' ) "$individual_config"



    num_active_connections=$(( num_active_connections + 1))
}
