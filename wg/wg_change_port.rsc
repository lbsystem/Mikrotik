:if ([/interface pppoe-client get PPPoE-out running]=true) do={
:local continue true;
:log info "Start....."
while ($continue) do={
:set $homebak [:rndnum from=10000 to=50000];
interface wireguard disable WG-homebak;
interface wireguard set WG-homebak listen-port=$homebak;
interface wireguard peers set numbers=0 endpoint-port=$homebak;
/system/ssh user=root address=xxx.xxx.xxx.xxx command="wg set wg0 listen-port $homebak"
/system/ssh user=root address=xxx.xxx.xxx.xxx command="ufw allow $homebak/udp"
interface wireguard enable WG-homebak;
:delay 3000ms;
if ([/ping address=10.10.10.2 count=1 as-value]->"status"=null) do={:set $continue false} else={:log info "Try it again"}
}
}