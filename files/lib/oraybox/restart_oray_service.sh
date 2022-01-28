#!/bin/sh

logger "[oraybox_sn] get sn from remote server is success, now restart VPN service"
/etc/init.d/orayboxvpn_s restart >/dev/null 2>&1

echo "get sn from remote server is success, restart services is success"
