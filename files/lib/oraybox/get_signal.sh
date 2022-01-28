#!/bin/sh

sig_info=$(comgt sig 2>/dev/null | grep 'Signal Quality')
[ -z "$sig_info" ] && echo -e "0\c" && exit 0

sig_current=$(echo $sig_info | awk -F 'Signal Quality: ' '{print $2}' | awk -F ',' '{print $1}')
[ -z "$sig_current" ] && [ -n "$1" ] && [ "$1" == "sig_db" ] && echo -e "-100\c" && exit 0
[ -n "$1" ] && [ "$1" == "sig_db" ] && echo -e "$sig_current\c" && exit 0
sig_full=$(echo $sig_info | awk -F 'Signal Quality: ' '{print $2}' | awk -F ',' '{print $2}')

[ -z "$sig_current" ] && echo -e "0\c" && exit 0
[ "$sig_current" -ge 10 ] && [ "$sig_current" -lt 15 ] && echo -e "1\c"
[ "$sig_current" -ge 15 ] && [ "$sig_current" -lt 20 ] && echo -e "2\c"
[ "$sig_current" -ge 20 ] && echo -e "3\c"
