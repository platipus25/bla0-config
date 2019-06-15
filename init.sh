# Wifi
SSID="MyNetworkSSID"
PSK="Pa55w0rd1234"


touch ssh

tee headlessconfig.txt <<EOF
# uncomment to force a specific HDMI mode (this will force VGA)
hdmi_group=2
hdmi_mode=35

[pi0]
# Raspberry pi zero otg
dtoverlay=dwc2
[all]
EOF

tee -a config.txt <<EOF

include headlessconfig.txt
EOF

tee wpa_supplicant.conf <<EOF
country=us
update_config=1
ctrl_interface=/var/run/wpa_supplicant

network={
    scan_ssid=1
    ssid="$SSID"
    psk="$PSK"
}
EOF

CMD="$(cat cmdline.txt)"

commands=($CMD)
for command in $CMD
do
    #if ["$command" == "rootwait"] 
    #    then
    #   echo "Add in modules-load=dwc2,g_ether"
    #fi
    echo $command
done