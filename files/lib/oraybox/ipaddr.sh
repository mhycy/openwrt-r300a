#!/bin/sh

#通过ip地址和掩码地址得出网络地址
get_net_address()
{
	local dev_ip="$1"
	local dev_mask="$2"
	ipcalc.sh "$dev_ip" "$dev_mask" | grep 'NETWORK=' | cut -d '=' -f2
}

get_net_address_cidr()
{
	local dev_ip="$1"
	local dev_mask="$2"
	local ret=''
	ret=$(ipcalc.sh "$dev_ip" "$dev_mask" | grep 'NETWORK=' | cut -d '=' -f2)
	ret=${ret}/$(ipcalc.sh "$dev_ip" "$dev_mask" | grep 'PREFIX=' | cut -d '=' -f2)
	echo $ret
}

