#!/bin/sh

. /lib/functions.sh
. /lib/oraybox/util.sh

machine=$(get_machine_name)
device="/dev/ttyUSB1"

[ "$machine" = "$MACHINE_R300_2121G" ] && device="/dev/ttyUSB3"

is_use_meig750_machine "$machine" && {
	sig_info=$(exec_at_command "$device" "AT+SGCELLINFO")
	mcc=$(echo "$sig_info" | grep "MCC:" | cut -d "," -f1 | cut -d ":" -f2 | sed 's/\n//g')
	echo "mcc:$mcc"
	mnc=$(echo "$sig_info" | grep "MNC:" | cut -d "," -f2 | cut -d ":" -f2 | sed 's/\n//g')
	echo "mnc:$mnc"
	cell_id=$(echo "$sig_info" | grep "CELL_ID:" | cut -d ":" -f2 | sed 's/\n//g')
	echo "cell_id:$cell_id"
	lac_id=$(echo "$sig_info" | grep "LAC_ID:" | cut -d ":" -f2 | sed 's/\n//g')
	echo "lac_id:$lac_id"
	rssi=$(echo "$sig_info" | grep "RSSI:" | cut -d ":" -f2 | sed 's/\n//g')
	echo "rssi:$rssi"
	rsrp=$(echo "$sig_info" | grep "RSRP:" | cut -d ":" -f2 | sed 's/\n//g')
	echo "rsrp:$rsrp"
	rsrq=$(echo "$sig_info" | grep "RSRQ:" | cut -d ":" -f2 | sed 's/\n//g')
	echo "rsrq:$rsrq"
}
is_use_ec200t_machine "$machine" && {
	cell_info=$(exec_at_command "$device" "AT+QENG=\"servingcell\"")
	cell_info="$(echo "$cell_info"|grep 'QENG:'|cut -d: -f2)"
	mode="$(echo "$cell_info"|cut -d, -f3|sed 's/\"//g')"
	if [ "$mode" = "GSM" ] || [ "$mode" = "WCDMA" ];then
		mcc="$(echo "$cell_info"|cut -d, -f4)"
		mnc="$(echo "$cell_info"|cut -d, -f5)"
		lac_id="$(echo "$cell_info"|cut -d, -f6)"
		cell_id="$(echo "$cell_info"|cut -d, -f7)"
	elif [ "$mode" = "LTE" ];then
		mcc="$(echo "$cell_info"|cut -d, -f5)"
		mnc="$(echo "$cell_info"|cut -d, -f6)"
		lac_id="$(echo "$cell_info"|cut -d, -f13)"
		cell_id="$(echo "$cell_info"|cut -d, -f7)"
	fi
	echo "mcc:$mcc"
	echo "mnc:$mnc"
	echo "cell_id:$cell_id"
	echo "lac_id:$lac_id"

	sig_info=$(exec_at_command "$device" "AT+QCSQ")
	for line in $sig_info; do
		mode="$(echo "$line"|cut -d, -f1|sed 's/\"//g')"
		if [ "$mode" = "GSM" ] || [ "$mode" = "WCDMA" ] || [ "$mode" = "TDSCDMA" ]; then
			rssi="$(echo "$line"|cut -d, -f2)"
		elif [ "$mode" = "LTE" ]; then
			rssi="$(echo "$line"|cut -d, -f2)"
			rsrp="$(echo "$line"|cut -d, -f3)"
			rsrq="$(echo "$line"|cut -d, -f5)"
		else
			continue
		fi
	done
	echo "rssi:$rssi"
	echo "rsrp:$rsrp"
	echo "rsrq:$rsrq"
}

