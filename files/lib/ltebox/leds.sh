#!/bin/sh
# Copyright (C) 2013 OpenWrt.org

led_set_attr() {
	[ -f "/sys/class/leds/$1/$2" ] && echo "$3" > "/sys/class/leds/$1/$2"
}

led_timer() {
	led_set_attr $1 "trigger" "timer"
	led_set_attr $1 "delay_on" "$2"
	led_set_attr $1 "delay_off" "$3"
}

all_led_timer() {
	led_set_attr $extra_led "trigger" "timer"
	led_set_attr $wifi_led "trigger" "timer"
	led_set_attr $status_led "trigger" "timer"

	led_set_attr $extra_led "delay_on" "$1"
	led_set_attr $wifi_led "delay_on" "$1"
	led_set_attr $status_led "delay_on" "$1"

	led_set_attr $extra_led "delay_off" "$2"
	led_set_attr $wifi_led "delay_off" "$2"
	led_set_attr $status_led "delay_off" "$2"
}

led_on() {
	led_set_attr $1 "trigger" "none"
	led_set_attr $1 "brightness" 255
}

led_off() {
	led_set_attr $1 "trigger" "none"
	led_set_attr $1 "brightness" 0
}

led_on_type_gbox(){	
	led_set_attr $1 "trigger" "none"
	led_set_attr $1 "brightness" 0
}

led_off_type_gbox(){
	led_set_attr $1 "trigger" "none"
	led_set_attr $1 "brightness" 255
}

led_morse() {
	led_set_attr $1 "trigger" "morse"
	led_set_attr $1 "delay" "$2"
	led_set_attr $1 "message" "$3"
}

status_led_set_timer() {
	led_timer $status_led "$1" "$2"
	[ -n "$status_led2" ] && led_timer $status_led2 "$1" "$2"
}

status_led_set_heartbeat() {
	led_set_attr $status_led "trigger" "heartbeat"
}

status_led_set_morse() {
	led_morse $status_led "$1" "$2"
	[ -n "$status_led2" ] && led_morse $status_led2 "$1" "$2"
}

status_led_on() {
	led_on $status_led
	[ -n "$status_led2" ] && led_on $status_led2
}

status_led_off() {
	led_off $status_led
	[ -n "$status_led2" ] && led_off $status_led2
}

status_led_on_type_gbox() {
	led_on_type_gbox $status_led
	[ -n "$status_led2" ] && led_on_type_gbox $status_led2
}
status_led_off_type_gbox() {
	led_off_type_gbox $status_led
	[ -n "$status_led2" ] && led_off_type_gbox $status_led2
}
wifi_led_on() {
	led_on $wifi_led
}

wifi_led_off() {
	led_off $wifi_led
}

extra_led_on() {
	led_on $extra_led
}

extra_led_off() {
	led_off $extra_led
}

extra_led_blink_middle() {
	led_timer $extra_led 500 500
}

status_led_off() {
	led_off $status_led
	[ -n "$status_led2" ] && led_off $status_led2
}

status_led_blink_slow() {
	led_timer $status_led 1000 1000
}

status_led_blink_middle() {
	led_timer $status_led 500 500
}

status_led_blink_fast() {
	led_timer $status_led 100 100
}

status_led_blink_preinit() {
	led_timer $status_led 200 200
}

status_led_blink_failsafe() {
	led_timer $status_led 50 50
}

status_led_net_on(){
	status_led_on $wifi_led
}

status_led_net_error(){
	status_led_on $status_led
}

extra_led_blink_fast() {                                         
        led_timer $extra_led 100 100                             
} 

extra_led_blink_middle() {                                         
        led_timer $extra_led 500 500                             
} 

all_led_blink_fast() {
	led_on	$extra_led
	led_on $wifi_led
	led_on $status_led 
	all_led_timer 500 500
}

blue_led_blink_middle() {
	led_off $wifi_led
	led_off $status_led
	led_timer $extra_led 500 500
}

blue_led_on() {
	led_off $wifi_led
	led_off $status_led
	led_on $extra_led
}

green_led_blink_middle() {
	led_off $wifi_led
	led_off $extra_led
	led_timer $status_led 500 500
}

green_led_on() {
	led_off $wifi_led
	led_off $extra_led
	led_on $status_led
}
  
red_led_blink_fast() {
 	led_off $status_led
        led_off $extra_led
        led_timer $wifi_led 200 200     #red led blink
}

all_led_on() {
	status_led_on
	extra_led_on
	wifi_led_on
}

all_led_off() {
	status_led_off
	extra_led_off
	wifi_led_off
}

sig_led_level_zero() {
	led_off $sig_first
	led_off $sig_second
	led_off $sig_third
}

sig_led_level_one() {
	led_on $sig_first
	led_off $sig_second
	led_off $sig_third
}

sig_led_level_two() {
	led_on $sig_first
	led_on $sig_second
	led_off $sig_third
}

sig_led_level_three() {
	led_on $sig_first
	led_on $sig_second
	led_on $sig_third
}

signal_led_on() {
	led_on $led_4g
}

signal_led_off() {
	led_off $led_4g
}

signal_led_blink_middle() {
	led_timer $led_4g 500 500
}


vpn_led_on() {
	led_on $vpn_led
}

vpn_led_off() {
	led_off $vpn_led
}

vpn_led_blink_middle() {
	led_timer $vpn_led 500 500
}


