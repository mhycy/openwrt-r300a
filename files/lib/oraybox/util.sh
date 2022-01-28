#!/bin/sh
. /usr/share/libubox/jshn.sh

#所有机型名称
MACHINE_X1_1111="OrayBox X1-1111"
MACHINE_X1_2111="OrayBox X1-2111"
MACHINE_E80_1110="OrayBox E80-1110"
MACHINE_P1_2111="OrayBox P1-2111"
MACHINE_X3_D1509="OrayBox X3-D1509"
MACHINE_X3_D1509A="OrayBox X3-D1509A"
MACHINE_X3_D1509B="OrayBox X3-D1509B"
MACHINE_X3_2151="OrayBox X3-2151"
MACHINE_X3_3251="OrayBox X3-3251"
MACHINE_X3PRO_1153="OrayBox X3PRO-1153"
MACHINE_P5_1210="OrayBox P5-1210"
MACHINE_P5_2210="OrayBox P5-2210"
MACHINE_GBOX_1230="OrayBox GBox-1230"
MACHINE_X5_1253="OrayBox X5-1253"
MACHINE_X5_2253="OrayBox X5-2253"
MACHINE_X5_3353="OrayBox X5-3353"
MACHINE_X5_4253="OrayBox X5-4253"
MACHINE_X5_5255="OrayBox X5-5255"
MACHINE_G5_1250="OrayBox G5-1250"
MACHINE_G5_2250="OrayBox G5-2250"
MACHINE_A5_00="OrayBox A500"
MACHINE_X6_1293P="OrayBox X6-1293P"
MACHINE_X6_2293P="OrayBox X6-2293P"
MACHINE_X6_3293P="OrayBox X6-3293P"
MACHINE_V5_1240="OrayBox V5-1240"
MACHINE_G100PRO_1240="OrayBox G100Pro-1240"
MACHINE_G100PRO_2240="OrayBox G100Pro-2240"
MACHINE_G300PRO_1440="OrayBox G300Pro-1440"
MACHINE_G300PRO_2440="OrayBox G300Pro-2440"
MACHINE_V2000_1260="OrayBox V2000-1260"
MACHINE_V3000_1480="OrayBox V3000-1480"
MACHINE_E3_1141="OrayBox E3-1141"
MACHINE_ORH_260="OrayBox ORH-260"
MACHINE_ORH_180="OrayBox ORH-180"
MACHINE_ORG_220="OrayBox ORG-220"
MACHINE_ORH_100="OrayBox ORH-100"
MACHINE_ORG_900="OrayBox ORG-900"
MACHINE_ORG_1100="OrayBox ORG-1100"
MACHINE_R100_1110="OrayBox R100-1110"
MACHINE_R300_1121G="OrayBox R300-1121G"
MACHINE_R300_2121G="OrayBox R300-2121G"
MACHINE_R300A_1121G="OrayBox R300A-1121G"
MACHINE_R300C_1121G="OrayBox R300C-1121G"
MACHINE_X4_1123G="OrayBox X4-1123G"
MACHINE_X4_2123G="OrayBox X4-2123G"
MACHINE_X4C_1141G="OrayBox X4C-1141G"
MACHINE_R20_1150G="OrayBox R20-1150G"
MACHINE_R300S_WT6320="OrayBox ZD-MR40-01/W"
MACHINE_R300S_1151G="OrayBox R300S-1151G"

#所有机型的类型
MACHINE_TYPE_X1="X1"
MACHINE_TYPE_X3="X3"
MACHINE_TYPE_X5="X5"
MACHINE_TYPE_G5="G5"
MACHINE_TYPE_A5="A5"
MACHINE_TYPE_X6="X6"
MACHINE_TYPE_V5="V5"
MACHINE_TYPE_E3="E3"
MACHINE_TYPE_R100="R100"
MACHINE_TYPE_R300="R300"
MACHINE_TYPE_R300C="R300C"
MACHINE_TYPE_X4="X4"
MACHINE_TYPE_X4C="X4C"
MACHINE_TYPE_R20="R20"
MACHINE_TYPE_R300S="R300S"
MACHINE_TYPE_E80="E80"
MACHINE_TYPE_GBOX="GBOX"

# 没有wifi机型列表
no_wifi_machine_array="
MACHINE_G5_1250 
MACHINE_G5_2250 
MACHINE_ORG_220 
MACHINE_V5_1240 
MACHINE_G100PRO_1240 
MACHINE_G100PRO_2240 
MACHINE_ORG_1100 
MACHINE_G300PRO_1440 
MACHINE_G300PRO_2440 
MACHINE_V2000_1260 
MACHINE_V3000_1480 
MACHINE_A5_00 
MACHINE_P1_2111 
MACHINE_P5_1210 
MACHINE_P5_2210 
MACHINE_ORG_900 
MACHINE_E80_1110 
MACHINE_R100_1110 
MACHINE_R20_1150G
MACHINE_GBOX_1230
"

# 没有lan口机型列表
no_lan_machine_array="
MACHINE_P1_2111 
MACHINE_P5_1210 
MACHINE_P5_2210 
MACHINE_ORG_900 
MACHINE_R100_1110 
MACHINE_E80_1110
"

# 支持加密芯片机型列表
support_encrypt_machine_array="
MACHINE_X3_3251 
MACHINE_X3PRO_1153 
MACHINE_X5_3353 
MACHINE_X5_4253 
MACHINE_X5_5255 
MACHINE_G5_1250 
MACHINE_G5_2250 
MACHINE_A5_00 
MACHINE_X6_2293P 
MACHINE_X6_3293P 
MACHINE_X1_2111 
MACHINE_E80_1110 
MACHINE_R100_1110 
MACHINE_P5_1210 
MACHINE_P5_2210 
MACHINE_P1_2111 
MACHINE_ORH_100 
MACHINE_ORG_900  
MACHINE_ORH_260 
MACHINE_ORH_180 
MACHINE_ORG_220 
MACHINE_R300_1121G 
MACHINE_R300_2121G 
MACHINE_R300A_1121G 
MACHINE_R300C_1121G 
MACHINE_X4C_1141G  
MACHINE_R300S_WT6320 
MACHINE_R300S_1151G
"

# 使用移远4G模块机型列表
use_ec200t_machine_array="
MACHINE_R300C_1121G 
MACHINE_X4C_1141G 
MACHINE_R300A_1121G
"

# 使用美格4G模块机型列表
use_meig750_machine_array="
MACHINE_R300_1121G 
MACHINE_R300_2121G 
MACHINE_X4_1123G 
MACHINE_X4_2123G 
MACHINE_R300S_WT6320 
MACHINE_R300S_1151G 
MACHINE_E3_1141
"

#获取当前机型
get_machine_name()
{
    . /lib/oraybox/machine.conf
	echo $oraybox_machine_name
}

#获取当前机型类型
get_machine_type()
{
        local machine_name=$(get_machine_name)
        if [ "$machine_name" == "$MACHINE_X1_1111" -o "$machine_name" == "$MACHINE_ORH_100" -o "$machine_name" == "$MACHINE_X1_2111" -o "$machine_name" == "$MACHINE_P1_2111" ]; then
                echo $MACHINE_TYPE_X1
        elif [ "$machine_name" == "$MACHINE_X3_D1509" -o "$machine_name" == "$MACHINE_X3_D1509A" -o "$machine_name" == "$MACHINE_X3_2151" -o "$machine_name" == "$MACHINE_X3_3251"  -o "$machine_name" == "$MACHINE_X3PRO_1153" -o "$machine_name" == "$MACHINE_ORH_180" ]; then
                echo $MACHINE_TYPE_X3
        elif [ "$machine_name" == "$MACHINE_P5_1210" -o "$machine_name" == "$MACHINE_P5_2210" -o "$machine_name" == "$MACHINE_ORG_900" -o "$machine_name" == "$MACHINE_X5_1253" -o "$machine_name" == "$MACHINE_X5_2253" -o "$machine_name" == "$MACHINE_X5_3353" -o "$machine_name" == "$MACHINE_X5_4253" -o "$machine_name" == "$MACHINE_X5_5255" -o "$machine_name" == "$MACHINE_ORH_260" ]; then
                echo $MACHINE_TYPE_X5
        elif [ "$machine_name" == "$MACHINE_G5_1250" -o "$machine_name" == "$MACHINE_ORG_220" -o "$machine_name" == "$MACHINE_G5_2250" ]; then
                echo $MACHINE_TYPE_G5
        elif [ "$machine_name" == "$MACHINE_A5_00" ]; then
                echo $MACHINE_TYPE_A5
        elif [ "$machine_name" == "$MACHINE_X6_1293P" -o "$machine_name" == "$MACHINE_X6_2293P" -o "$machine_name" == "$MACHINE_X6_3293P" ]; then
                echo $MACHINE_TYPE_X6
        elif [ "$machine_name" == "$MACHINE_V5_1240" -o "$machine_name" == "$MACHINE_G100PRO_1240" -o "$machine_name" == "$MACHINE_G100PRO_2240" -o "$machine_name" == "$MACHINE_ORG_1100" -o "$machine_name" == "$MACHINE_G300PRO_1440" -o "$machine_name" == "$MACHINE_G300PRO_2440" -o "$machine_name" == "$MACHINE_V2000_1260" -o "$machine_name" == "$MACHINE_V3000_1480" ]; then
                echo $MACHINE_TYPE_V5
        elif [ "$machine_name" == "$MACHINE_E3_1141" ]; then
                echo $MACHINE_TYPE_E3
        elif [ "$machine_name" == "$MACHINE_R300_1121G" -o "$machine_name" == "$MACHINE_R300_2121G" ]; then
                echo $MACHINE_TYPE_R300
        elif [ "$machine_name" == "$MACHINE_R300A_1121G" ]; then
                echo $MACHINE_TYPE_R300A
        elif [ "$machine_name" == "$MACHINE_R300C_1121G" ]; then
                echo $MACHINE_TYPE_R300C
        elif [ "$machine_name" == "$MACHINE_X4_1123G" -o "$machine_name" == "$MACHINE_X4_2123G" ]; then
                echo $MACHINE_TYPE_X4
  	elif [ "$machine_name" == "$MACHINE_X4C_1141G" ]; then
		echo $MACHINE_TYPE_X4C
	elif [ "$machine_name" == "$MACHINE_R20_1150G" ]; then
                echo $MACHINE_TYPE_R20
	elif [ "$machine_name" == "$MACHINE_R300S_WT6320" -o "$machine_name" == "$MACHINE_R300S_1151G" ]; then
		echo $MACHINE_TYPE_R300S
	elif [ "$machine_name" == "$MACHINE_E80_1110" ]; then
                echo $MACHINE_TYPE_E80
	elif [ "$machine_name" == "$MACHINE_R100_1110" ]; then
                echo $MACHINE_TYPE_R100
	elif [ "$machine_name" == "$MACHINE_GBOX_1230" ]; then
                echo $MACHINE_TYPE_GBOX
        else
                echo ""
        fi
}

. /etc/openwrt_release
get_firmware_version()
{
	echo $DISTRIB_RELEASE
}

get_firmware_type()
{
	echo $DISTRIB_ID
}

#获取当前安装的包的信息
get_all_installed_package_info()
{
	opkg list-installed | awk -F' - ' '{print $1" "$2}' 2>/dev/null
}

#获取当前安装的某个包的信息
get_installed_package_info()
{
	package_name="$1"
	[ -z "$package_name" ] &&  return 1

	opkg list-installed | grep "$package_name" | awk -F' - ' '{print $1" "$2}' 2>/dev/null
}

#获取某个网络设备的IP地址
get_net_device_ip()
{
	local dev="$1"
	[ -z "$dev" ] && return 1

	ifconfig "$dev" 2>/dev/null | grep 'inet addr' | cut -d: -f2 | awk '{print $1}' | head -n 1
}

#获取某个网络设备的广播IP地址
get_net_device_bcast_ip()
{
	local dev="$1"
	[ -z "$dev" ] && return 1

	ifconfig "$dev" 2>/dev/null | grep 'inet addr' | cut -d: -f3 | awk '{print $1}' | head -n 1
}

#获取某个网络设备的子网掩码
get_net_device_mask()
{
	local dev="$1"
	[ -z "$dev" ] && return 1

	ifconfig "$dev" 2>/dev/null | grep 'inet addr' | cut -d: -f4 | awk '{print $1}' | head -n 1
}

#子网掩码计算
mask_to_int() 
{
	a=$(echo "$1" | awk -F "." '{print $1" "$2" "$3" "$4}')
	for num in $a;
	do
		while [ $num != 0 ];do
			echo -n $(($num%2)) >> /tmp/num;
			num=$(($num/2));
		done
	done
	echo $(grep -o "1" /tmp/num | wc -l)
	rm /tmp/num
}

#获取某个网络设备的网络IP
get_net_device_net_ip()
{
	local dev_ip=$(get_net_device_ip "$1")
	local dev_mask=$(get_net_device_mask "$1")
	[ -z "$dev_ip" -o -z "$dev_mask" ] && return 1

	local net_ip=$(ipcalc.sh "$dev_ip" "$dev_mask" | grep 'NETWORK=' | cut -d '=' -f2)
	local mask=$(ipcalc.sh "$dev_ip" "$dev_mask" | grep 'PREFIX=' | cut -d '=' -f2)
	echo $net_ip/$mask
}

#获取wan口的设备名称
get_wan_device()
{
	local dev=''
	dev=$(ubus call network.interface.wan3g status 2> /dev/null | grep l3_device | cut -d':' -f2 | cut -d'"' -f2 | head -n 1)
	[ -z "$dev" ] || {
		echo "$dev"
		return 0
	}

	dev=$(ubus call network.interface.wwan status 2> /dev/null | grep l3_device | cut -d':' -f2 | cut -d'"' -f2 | head -n 1)
	[ -z "$dev" ] || {
		echo "$dev"
		return 0
	}

	dev=$(ubus call network.interface.wan status 2> /dev/null | grep l3_device | cut -d':' -f2 | cut -d'"' -f2 | head -n 1)
	[ -z "$dev" ] || {
		echo "$dev"
		return 0
	}
	
	dev=$(ubus call network.interface.wan status 2> /dev/null | grep device | cut -d':' -f2 | cut -d'"' -f2 | head -n 1)
	[ -z "$dev" ] || {
		echo "$dev"
		return 0
	}

	return 1
}

#获取wan2口的设备名称(X6专用)
get_wan2_device()
{
	local dev=''
	dev=$(ubus call network.interface.wan2 status 2> /dev/null | grep l3_device | cut -d':' -f2 | cut -d'"' -f2 | head -n 1)
	[ -z "$dev" ] || {
		echo "$dev"
		return 0
	}

	dev=$(ubus call network.interface.wan2 status 2> /dev/null | grep device | cut -d':' -f2 | cut -d'"' -f2 | head -n 1)
	[ -z "$dev" ] || {
		echo "$dev"
		return 0
	}

	return 1
}

#接口是否在线(是否有拿到ip)
iface_is_online()
{
	local iface="$1"
	local up_value=0
	json_cleanup
	json_load "$(ubus call network.interface.${iface} status 2>/dev/null)" 2>/dev/null && \
		json_get_var up_value up && \
		test $up_value -eq 1
}

#变量是否在数组中,去掉设备型号中的OrayBox 
is_value_in_array()
{
	local machine_name="$1"
	local arr="$2"
	for x in $arr; do
		local compare_machine_name=$(eval "echo \$$x")
		[ "$machine_name" = "$compare_machine_name" ] && {
		    return 0
		}
	done
	return 1
}

is_no_wifi_machine()
{
        local machine="$1"
	is_value_in_array "$machine" "$no_wifi_machine_array" && return 0
	return 1
}

is_no_lan_machine()
{
	local machine="$1"
	is_value_in_array "$machine" "$no_lan_machine_array" && return 0
	return 1
}

is_support_encrypt_machine()
{
	local machine="$1"
	is_value_in_array "$machine" "$support_encrypt_machine_array" && return 0
	return 1
}

COMGT_EXE_SCRIPT="/etc/gcom/nradio/exe.gcom"

exec_at_command() {
    local tty
    local cmd
    local res

    tty="$1"
    cmd="$2"
    res=$(CMD="$cmd" comgt -d "$tty" -s "$COMGT_EXE_SCRIPT")

    echo "$res"
}

is_use_ec200t_machine()
{
	local machine_name="$1"
	is_value_in_array "$machine_name" "$use_ec200t_machine_array" && return 0
	return 1
}

is_use_meig750_machine()
{
	local machine_name="$1"
	is_value_in_array "$machine_name" "$use_meig750_machine_array" && return 0
	return 1
}

#获取user-agent
get_user_agent()
{
	local version=$(get_firmware_version)
	local arch=$(uname -m)
	local machine=$(get_machine_name)
	machine=$(echo $machine | cut -d' ' -f2)
	local type=$(get_firmware_type)
	local user_agent="PgyOraybox/$version (openwrt; $arch; $machine/$type)"
	echo $user_agent
}

