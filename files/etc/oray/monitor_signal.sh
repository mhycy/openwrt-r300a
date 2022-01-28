#!/bin/sh

. /lib/oraybox/util.sh
. /lib/oraybox/led.sh
. /lib/functions.sh
. /lib/oraybox/net_test.sh

get_led_switch() {
	config_load led_ctrl
	config_get switch base switch '1'
	echo $switch
}

get_status_led
led_switch=$(get_led_switch)
old_switch=1
switch_change_flag=0
net_test_index=0
machine_name=$(get_machine_name)

device="/dev/ttyUSB1"

# R300-2121G 4g modem控制口变为/dev/ttyUSB3
[ "$machine_name" = "$MACHINE_R300_2121G" ] && device="/dev/ttyUSB3"

get_rssi_sig_level() {
	sig_info=$(comgt sig -d "$device" >/dev/null | grep 'Signal Quality')
	[ -z "sig_info" ] && return 0

	sig_current=$(echo $sig_info | awk -F 'Signal Quality: ' '{print $2}' | awk -F ',' '{print $1}')
	sig_full=$(echo $sig_info | awk -F 'Signal Quality: ' '{print $2}' | awk -F ',' '{print $2}')
	
	[ $sig_current -eq 99 ] && return 0
	[ $sig_current -ge 10 ] && [ $sig_current -lt 15 ] && return 1
	[ $sig_current -ge 15 ] && [ $sig_current -lt 20 ] && return 2
	[ $sig_current -ge 20 ] && return 3

	return 0
}

# 美格SLM750获取信号强度
get_meig750_sig_level(){
	sig_info=$(exec_at_command "$device" "AT+SGCELLINFO")
	rsrp=$(echo "$sig_info" | grep "RSRP:" | cut -d ":" -f2 | sed 's/\n//g')
	[ -n "$rsrp" ] && {
		[ $rsrp -le -100 ] && return 0
		[ $rsrp -gt -100 ] && [ $rsrp -le -90 ] && return 1
		[ $rsrp -gt -90 ] && [ $rsrp -lt -80 ] && return 2
		[ $rsrp -ge -80 ] && return 3
	}

	get_rssi_sig_level
	return $?
}

# 移远EC200T获取信号强度
get_ec200t_sig_level() {
	sig_info=$(exec_at_command "$device" "AT+QCSQ")
	for line in $sig_info; do
		mode="$(echo "$line"|cut -d, -f1|sed 's/\"//g')"
		if [ "$mode" = "GSM" ] || [ "$mode" = "WCDMA" ] || [ "$mode" = "TDSCDMA" ]; then
			rssi="$(echo "$line"|cut -d, -f2)"
		elif [ "$mode" = "LTE" ]; then
			rssi="$(echo "$line"|cut -d, -f2)"
			rsrp="$(echo "$line"|cut -d, -f3)"
		else
			continue
		fi
	done

	[ -n "$rsrp" ] && {
		[ $rsrp -le -100 ] && return 0
		[ $rsrp -gt -100 ] && [ $rsrp -le -90 ] && return 1
		[ $rsrp -gt -90 ] && [ $rsrp -lt -80  ] && return 2
		[ $rsrp -ge -80 ] && return 3
	}

	get_rssi_sig_level
	return $?
}

test_net() {
	net_test && return 0

	return 1
}

io_status_set()
{
	local machine_name=$(get_machine_name)
	if [ "$machine_name" == "$MACHINE_E3_1141" ]; then
		case $1 in
			"vpn_connected")
              			echo "1" > /sys/obox_status/vpn	
              		;;
              		"vpn_disconnected")
              			echo "0" > /sys/obox_status/vpn	
              		;;
              		"net_connected")
              			echo "1" > /sys/obox_status/net	
              		;;
              		"net_disconnected")
              			echo "0" > /sys/obox_status/net	
              		;;
		esac
	fi
}
while true;do
	old_switch=$led_switch
	led_switch=$(get_led_switch)
	if [ "$old_switch" != "$led_switch" ]; then
		switch_change_flag=1
	else
		switch_change_flag=0
	fi
	[ "$led_switch" == "0" ] && {
		[ "$switch_change_flag" == "1" ] && {
			all_led_off
		}
		sleep 10
		continue
	}
	
	if [ "$machine_name" == "$MACHINE_GBOX_1230" ];then
		test_net		
		if [ $? -eq 0 ];then
			led_status_set "net_connected" "$switch_change_flag"
		else
			led_status_set "net_disconnected" "$switch_change_flag"	
		fi
	else
	
		VPN_STATUS=$(cat /tmp/orayboxvpn_connect_status 2>/dev/null)
		if [ "$VPN_STATUS" = "connected" ];then
			#VPN已连接
			led_status_set "vpn_connected" "$switch_change_flag"
			io_status_set "vpn_connected"
			io_status_set "net_connected"
		elif [ "$VPN_STATUS" = "tryconnect" ];then
			#VPN尝试连接中
			led_status_set "vpn_tryconnect" "$switch_change_flag"
			io_status_set "vpn_disconnected"
			io_status_set "net_disconnected"
		else
			#VPN连接断开,首先检测网络是否正常,再设置不同的状态
			io_status_set "vpn_disconnected"
			test_net		
			if [ $? -eq 0 ];then
				led_status_set "vpn_disconnected" "$switch_change_flag"
				io_status_set "net_connected"
			else
				led_status_set "net_disconnected" "$switch_change_flag"
				io_status_set "net_disconnected"
			fi
		fi
	fi
		
	config_load network
	current_wan_proto=""
	current_wan_spare_proto=""
	sig_level=0
	config_get current_wan_proto wan proto "dhcp"
	config_get current_wan_spare_proto wan_spare proto "dhcp"

	[ "$machine_name" == "$MACHINE_R300_1121G" -o "$machine_name" == "$MACHINE_R300_2121G" -o "$machine_name" == "$MACHINE_R300S_WT6320" -o "$machine_name" == "$MACHINE_R300S_1151G" ] && {
		[ "$current_wan_proto" == "wwan" ] && {
			ubus call network.interface.wan status | grep '"up": true' && {
				get_meig750_sig_level
				sig_level=$?
			}
        } || {
		    [ "$current_wan_spare_proto" == "wwan" ] && {
                ubus call network.interface.wan_spare status | grep '"up": true' && {
                    get_meig750_sig_level
                    sig_level=$?
			    }
			}
	    }
		case $sig_level in
			0)
			sig_led_level_zero
			;;
			1)
			sig_led_level_one
			;;
			2)
			sig_led_level_two
			;;
			3)
			sig_led_level_three
			;;
		esac
    }

	[ "$machine_name" == "$MACHINE_R300C_1121G" -o "$machine_name" == "$MACHINE_R300A_1121G" ] && {
		[ "$current_wan_proto" == "wwan" ] && {
			sig_level=0
			ubus call network.interface.wan status | grep '"up": true' && {
				get_ec200t_sig_level
				sig_level=$?
			}
		} || {
		    [ "$current_wan_spare_proto" == "wwan" ] && {
                ubus call network.interface.wan_spare status | grep '"up": true' && {
                    get_ec200t_sig_level
                    sig_level=$?
			    }
            }
	    }
		case $sig_level in
			0)
			sig_led_level_zero
			;;
			1)
			sig_led_level_one
			;;
			2)
			sig_led_level_two
			;;
			3)
			sig_led_level_three
			;;
		esac
	}
	
	[ "$machine_name" == "$MACHINE_R20_1150G" ] && {
		if [ "$current_wan_proto" == "wwan" ];then
			signal_led_on
        else
            if [ "$current_wan_spare_proto" == "wwan" ];then
                signal_led_on
            else
                signal_led_off
            fi
		fi
	}

	[ "$machine_name" == "$MACHINE_X4C_1141G" ] && {
		if [ "$current_wan_proto" == "wwan" ];then
			ifconfig usb0 >/dev/null 2>&1 && signal_led_on
			ifconfig usb0 >/dev/null 2>&1 || signal_led_off
		else
            if [ "$current_wan_spare_proto" == "wwan" ];then
                ifconfig usb0 >/dev/null 2>&1 && signal_led_on
                ifconfig usb0 >/dev/null 2>&1 || signal_led_off
            else
			    signal_led_off
            fi
		fi
	}

	sleep 5
done
