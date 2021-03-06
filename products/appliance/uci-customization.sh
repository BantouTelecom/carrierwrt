#!/bin/sh

SAVE=/etc/factory-defaults/save

if [ ! -e $SAVE/CUSTOMIZATION ]; then
	# Set up networking:
	#
	#  eth0 - WAN
	#  eth1 - LAN (bridging only)
	#  eth2 - ADM (dhcp without gateway)
	#
	uci delete network.wan
	uci set network.wan=interface
	uci set network.wan.proto=dhcp
	uci set network.wan.ifname=eth0
	uci delete network.lan
	uci set network.lan=interface
	uci set network.lan.type=bridge
	uci set network.lan.proto=none
	uci set network.lan.ifname=eth1
	uci set network.lan.auto=1
	uci delete network.adm
	uci set network.adm=interface
	uci set network.adm.proto=dhcp
	uci set network.adm.ifname=eth2
	uci set network.adm.gateway='0.0.0.0'
	uci commit

	echo '' > $SAVE/CUSTOMIZATION
fi

exit 0
