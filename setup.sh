sudo apt-get update
sudo apt-get install dnsmasq -y

tee -a /etc/dhcpcd.conf <<EOF
interface usb0

static ip_address=192.168.2.1/24
static routers=192.168.2.1
static domain_name_servers=192.168.2.1
EOF

sudo service networking restart

ifconfig

cd /etc
sudo mv dnsmasq.conf dnsmasq.default

tee /etc/dhcpcd.conf <<EOF
interface=usb0
dhcp-range=192.168.1.2,192.168.1.254,255.255.255.0,12h
EOF

sudo service dnsmasq restart