#!/bin/sh
. /lib/oraybox/util.sh

get_wan_ifname() {
	local ifname=""
	if [ "$1" = "wan" ]; then
        ifname=$(get_wan_device)
        while [ -z "$ifname" ]
        do
                ifname=$(get_wan_device)
                sleep 1
        done
	elif [ "$1" = "wan2" ]; then
        ifname=$(get_wan2_device)
        while [ -z "$ifname" ]
        do
                ifname=$(get_wan2_device)
                sleep 1
        done
	fi
	echo "$ifname"
}

get_wanspare_ifname() {
	local ifname="$(uci get network.wan_spare.ifname)"
	local proto="$(uci get network.wan_spare.proto)"
	[ "$proto" == "pppoe" ] && ifname="pppoe-wan_spare"
	echo "$ifname"
}

get_wanspare_proto() {
	local proto="$(uci get network.wan_spare.proto)"
	echo "$proto"
}

get_iface_nexthop() {
	local iface="$1"
	local gw=""
	local gw6=""
	local info="$(ubus call network.interface.$iface status 2>/dev/null)"
	[ -z "$info" ] && return

	json_load "$info"
	if json_get_type status route && [ "$status" = array ]; then
		json_select route
		local index="1"
		while json_get_type status $index && [ "$status" = object ]; do
			json_select "$((index++))"
			json_get_var status target
			case "$status" in
				0.0.0.0)
					json_get_var gw nexthop;;
				::)
					json_get_var gw6 nexthop;;
			esac
			json_select ".."
		done
		json_select ".." 
	fi
	[ -z "$gw" ] && { 
		json_get_type status inactive
		[ "$status" = object ] && {
			json_select inactive 
			if json_get_type status route && [ "$status" = array ]; then
				json_select route
				local index="1"
				while json_get_type status $index && [ "$status" = object ]; do
					json_select "$((index++))"
					json_get_var status target
					case "$status" in
						0.0.0.0)
							json_get_var gw nexthop;;
						::)
							json_get_var gw6 nexthop;;
					esac
					json_select ".."
				done
			fi 
		}
	}
	echo $gw
}
