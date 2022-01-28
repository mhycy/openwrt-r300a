#!/bin/sh

. /lib/functions.sh
host_size=0
config_load testnet
config_get hosts "general" hosts
if [ -n "$hosts" ] ; then
	for host in $hosts 
	do
		host_size=$((host_size+1))
	done
else
	host_size=0
fi	

config_get send_interval "general" send_interval 1
config_get send_count "general" send_count 5
config_get max_loss_rate "general" max_loss_rate 70
config_get max_failed_count "general" max_failed_count 3
config_get timeout "general" timeout 1
config_get test_interval "general" test_interval 60
sends=$((host_size*send_count))
	
test_net_ping() {
	[ $host_size = 0 ] && return 0
	local iface="$1"
	local loss=0
	local loss_rate=0

	for i in $(seq 1 $send_count)
	do
		for host in $hosts 
		do
			if [ -n "$iface" ] ;then
				timeout -t $timeout ping $host -I "$iface"  -c 1 || loss=$((loss+1))
			else
				timeout -t $timeout ping $host -c 1 || loss=$((loss+1))
			fi
		done
		sleep $send_interval
	done
	[ $loss -ne 0 ] && loss_rate=$((loss*100/sends))
	[ $loss_rate -gt $max_loss_rate ] && return 1

	return 0
}

test_net_tcp() {
	[ $host_size = 0 ] && return 0
	local loss=0
	local loss_rate=0

	for i in $(seq 1 $send_count)
	do
		for host in $hosts 
		do	
			oray_net_test -s $host -p 443 -t $timeout || loss=$((loss+1))
		done
		sleep $send_interval
	done
	[ $loss -ne 0 ] && loss_rate=$((loss*100/sends))
	[ $loss_rate -gt $max_loss_rate ] && return 1

	return 0
}

test_net_dnslookup() {
	config_load testnet
	config_get servers "dns_lookup" server
	[ $host_size = 0 ] && return 0
	local iface="$1"

	for host in $hosts 
	do
		for server in servers 
		do	
			dns-lookup -i "$iface" -h "$host" -t "$((timeout*1000))" -D "$server" && return 0
		done
	done
}

net_test()
{
	local iface="$1"
	local test_type
	config_load testnet
	config_get test_type "general" test_type

	if [ -z "$test_type" -o "$test_type" == "ping" ] ; then
		test_net_ping "$iface"
		return $?
	fi
}

get_test_interval()
{
	local interval
	config_load testnet
	config_get test_interval "general" test_interval 60
	echo $test_interval
}
