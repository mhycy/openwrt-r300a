#! /bin/sh

. /lib/functions/leds.sh
. /lib/oraybox/util.sh

get_status_led() {
	
	local machine_name=$(get_machine_name)
	local machine_type=$(get_machine_type)
	if [ "$machine_type" == "$MACHINE_TYPE_X1" ]; then
		wifi_led="hc:green:wifi"
		extra_led="hc:green:extra"
		status_led="hc:green:status"

	elif [ "$machine_type" == "$MACHINE_TYPE_E80" ]; then
		wifi_led="hc:green:status"
		extra_led="hc:green:wifi"
		status_led="hc:green:extra"

	elif [ "$machine_type" == "$MACHINE_TYPE_R100" ]; then
		wifi_led="hc:green:status"
		extra_led="hc:green:wifi"
		status_led="hc:green:extra"

	elif [ "$machine_name" == "$MACHINE_X3_D1509" ]; then
		wifi_led="hc:green:wifi"
		extra_led="hc:green:internet"
		status_led="hc:green:status"

	elif [ "$machine_type" == "$MACHINE_TYPE_X3" ]; then
		wifi_led="hc:green:wifi"
		extra_led="hc:green:internet"
		status_led="hc:green:status"

	elif [ "$machine_name" == "$MACHINE_P5_1210" -o "$machine_name" == "$MACHINE_P5_2210" -o "$machine_name" == "$MACHINE_ORG_900" -o "$machine_name" == "$MACHINE_G5_2250" ]; then
		wifi_led="hc:green:wifi"
                extra_led="hc:green:status"
                status_led="hc:green:extra"

	elif [ "$machine_type" == "$MACHINE_TYPE_X5" ]; then
		wifi_led="hc:green:wifi"
		extra_led="hc:green:extra"
		status_led="hc:green:status"

	elif [ "$machine_type" == "$MACHINE_TYPE_G5" ]; then
		wifi_led="hc:green:wifi"
		extra_led="hc:green:extra"
		status_led="hc:green:status"


	elif [ "$machine_type" == "$MACHINE_TYPE_X6" ]; then
		wifi_led="hc:green:wifi"
		extra_led="hc:green:extra"
		status_led="hc:green:status"

	elif [ "$machine_type" == "$MACHINE_TYPE_E3" ]; then
		wifi_led="hc:green:wifi"
		extra_led="hc:green:internet"
		status_led="hc:green:status"

	elif [ "$machine_type" == "$MACHINE_TYPE_R300" ]; then
		wifi_led="hc:blue:red"
		extra_led="hc:blue:blue"
		status_led="hc:blue:green"
		sig_first="hc:blue:siginal3"
		sig_second="hc:blue:siginal2"
		sig_third="hc:blue:siginal1"
	
	elif [ "$machine_type" == "$MACHINE_TYPE_R300A" ]; then
		wifi_led="hc:blue:red"
		extra_led="hc:blue:blue"
		status_led="hc:blue:green"
		sig_first="hc:blue:siginal3"
		sig_second="hc:blue:siginal2"
		sig_third="hc:blue:siginal1"
	
	elif [ "$machine_type" == "$MACHINE_TYPE_R300C" ]; then
		wifi_led="hc:blue:red"
		extra_led="hc:blue:blue"
		status_led="hc:blue:green"
		sig_first="hc:blue:siginal3"
		sig_second="hc:blue:siginal2"
		sig_third="hc:blue:siginal1"
	
	elif [ "$machine_type" == "$MACHINE_TYPE_X4" ]; then
		wifi_led="hc:blue:green"
		status_led="hc:blue:blue"

	elif [ "$machine_type" == "$MACHINE_TYPE_R20" ]; then
		extra_led="hc:blue:green"
		status_led="hc:blue:blue"

	elif [ "$machine_type" == "$MACHINE_TYPE_X4C" ]; then
		wifi_led="hc:green:wifi"
		status_led="hc:green:status"
		extra_led="hc:green:internet"
		led_4g="hc:green:extra"

	elif [ "$machine_type" == "$MACHINE_TYPE_R300S" ]; then
		wifi_led="hc:blue:red"
		extra_led="hc:blue:blue"
		status_led="hc:blue:green"
		vpn_led="hc:blue:wifi"
		sig_first="hc:blue:siginal3"
		sig_second="hc:blue:siginal2"
		sig_third="hc:blue:siginal1"
	
	elif [ "$machine_name" == "$MACHINE_GBOX_1230" ]; then
		status_led="hc:green:status"
	
	fi
}

led_status_change() 
{
	get_status_led

	VPN_STATUS=$(cat /tmp/orayboxvpn_connect_status)
	NET_STATUS=$(cat /tmp/net_status)
	local machine_name=$(get_machine_name)
	local machine_type=$(get_machine_type)
	if [ "$machine_name" == "$MACHINE_X3_D1509" -o "$machine_name" == "$MACHINE_X3_D1509A" ]; then
		if [ $NET_STATUS -eq 0 ];then
			blue_led_off
		elif [ "tryconnect" = $VPN_STATUS ];then
			blue_led_blink_middle
		elif [ "connected" = $VPN_STATUS ];then
			blue_led_on
		elif [ "disconnected" = $VPN_STATUS ];then
			blue_led_off
		fi	
	
	else
		if [ $NET_STATUS -eq 0 ];then
			red_led_blink_fast
		elif [ "tryconnect" = $VPN_STATUS ];then
			blue_led_blink_middle
		elif [ "connected" = $VPN_STATUS ];then
			blue_led_on
		elif [ "disconnected" = $VPN_STATUS ];then
			green_led_on
		fi	
	fi
}

#$2代表灯开关状态发生变化(0,1)
led_status_set() 
{
       get_status_led
       local machine_name=$(get_machine_name)

       [ "$cur_led_status" == "$1" ] && [ "$2" != "1" ] && return
       cur_led_status="$1"

       case $1 in
               "vpn_tryconnect")
               if [ "$machine_name" == "$MACHINE_R20_1150G" ];then
	               extra_led_blink_middle
               elif [ "$machine_name" == "$MACHINE_X4_1123G" -o "$machine_name" == "$MACHINE_X4_2123G" ];then
	               return
               elif [ "$machine_name" == "$MACHINE_X4C_1141G" ];then
		       status_led_on
		       extra_led_blink_middle
	       else
	               blue_led_blink_middle
               fi
               ;;
               "vpn_connected")
               if [ "$machine_name" == "$MACHINE_R20_1150G" ];then
	               extra_led_on
	               status_led_on
               elif [ "$machine_name" == "$MACHINE_X4_1123G" -o "$machine_name" == "$MACHINE_X4_2123G" ];then
	               green_led_on
               elif [ "$machine_name" == "$MACHINE_X4C_1141G" ];then
		       status_led_on
		       extra_led_on
	       else
	               blue_led_on
               fi
               ;;
               "vpn_disconnected")
               if [ "$machine_name" == "$MACHINE_X3_D1509" -o "$machine_name" == "$MACHINE_X3_D1509A" ];then
                       blue_led_off
               elif [ "$machine_name" == "$MACHINE_R20_1150G" ];then
	               extra_led_off
	               status_led_on
               elif [ "$machine_name" == "$MACHINE_X4C_1141G" ];then
		       status_led_on
		       extra_led_off
               else
                       green_led_on
               fi
               ;;
               "net_connected")
               if [ "$machine_name" == "$MACHINE_GBOX_1230" ];then
                       status_led_on_type_gbox
               fi
               ;;
               "net_disconnected")
               if [ "$machine_name" == "$MACHINE_X3_D1509" -o "$machine_name" == "$MACHINE_X3_D1509A" ];then
                       blue_led_off
               elif [ "$machine_name" == "$MACHINE_R20_1150G" ];then
                       status_led_blink_middle
               elif [ "$machine_name" == "$MACHINE_X4C_1141G" ];then
		       extra_led_off
		       signal_led_off
		       status_led_blink_middle
               elif [ "$machine_name" == "$MACHINE_GBOX_1230" ];then
                       status_led_blink_middle
               else
                       red_led_blink_fast
               fi
               ;;
       esac
}
