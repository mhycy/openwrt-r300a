#!/bin/sh

# get interface use mode (wifi_sta/dhcp/pppoe/static/sim/sim2)
# 1 : interface name in /etc/config/network eg.wan wan_spare wan2 lan
get_iface_mode() {
	local iface=$1
	local mode
	local ifname
	mode=$(uci get network.$iface.proto 2>/dev/null)
	[ "$mode" == "wwan" ] && mode="sim"

	ifname=$(uci get network.$iface.ifname 2>/dev/null)
	[ "$ifname" == "apcli0" -o "$ifname" == "apclii0" -o "$ifname" == "apclix0" -o "$ifname" == "ra0" -o "$ifname" == "rai0" ] && mode="wifi_sta"

	is3g4g=$(uci get network.$iface.is3g4gmode 2>/dev/null)
	[ "$is3g4g" -eq "1" ] && mode="usb-3g"

	echo "$mode"
}

# get receive flow by interface
# 1: interface eg:br-lan
get_recv_flow() {
	local iface="$1"

	local flow=$(cat /proc/net/dev | grep "$iface:" | awk '{print $2}')
	[ -z "$flow" ] && flow=0
	echo "$flow"
}

# get transmit flow by interface
# 1: interface eg:br-lan
get_trans_flow() {
	local iface="$1"

	local flow=$(cat /proc/net/dev | grep "$iface:" | awk '{print $10}')
	[ -z "$flow" ] && flow=0
	echo "$flow"
}

# get total flow by interface
# 1: interface eg:br-lan
get_total_flow() {
	local iface="$1"

	local recv_flow=$(cat /proc/net/dev | grep "$iface:" | awk '{print $2}')
	[ -z "$recv_flow" ] && recv_flow=0
	local trans_flow=$(cat /proc/net/dev | grep "$iface:" | awk '{print $10}')
	[ -z "$trans_flow" ] && trans_flow=0

	local total_flow=$((recv_flow+trans_flow))
	echo "$total_flow"
}

