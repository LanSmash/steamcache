
#setup firewall and routing

#NETWORKADAPTER=eno1
NETWORKADAPTER=enp0s8
mv /etc/rc.local /etc/rc.local.bak

# DST 172.16.5.0/24 need to serve block.ls on port 80 for * vhosts.
# Intercept all other port 80 traffic to nginx port 3128.
echo iptables -t nat -I PREROUTING \
	! -s 172.17.0.0/16 ! -d 172.16.5.0/24 -i $NETWORKADAPTER \
	-p tcp -m tcp --dport 80 -j REDIRECT --to-ports 3128 >> /etc/rc.local
# The masquerades are for when this is functioning as a default gateway.
# It allows forwarding of traffic other than just intercepted HTTP.
echo iptables -t nat -I POSTROUTING \
	-o enp0s8 ! -p tcp -j MASQUERADE >> /etc/rc.local
echo iptables -t nat -I POSTROUTING \
	-o enp0s8 -p tcp ! --sport 80 -j MASQUERADE >> /etc/rc.local
# I think this is needed regardless of whether forwarding all traffic
echo sysctl -w net.ipv4.ip_forward=1 >> /etc/rc.local
chmod +x /etc/rc.local
/etc/rc.local

# delete NAT default route and reset DHCP on bridge to add it's default gateway
ip route del default
ifdown enp0s8; ifup enp0s8

# setup git and clone
apt-get install -y git-core
git clone https://github.com/LanSmash/ls-nginx.git /srv/nginx

# start docker container for steam caching
/srv/nginx/run.sh

echo "Install complete"
echo "Set the default gateway on your steam computers to:"
ip addr show dev enp0s8 | awk '
	/^[0-9]+:/ {
  	  sub(/:/,"",$2); iface=$2 }
	/^[[:space:]]*inet / {
  	  split($2, a, "/")
  	print iface" : "a[1] }'



