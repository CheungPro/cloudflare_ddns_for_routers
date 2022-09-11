# personal information
GAK="Change Into Yours"
zone_name=" domain" 
record_name_4="v4 domain"
record_name_6="v6 domain"

proxy="false"

# get ip address
ipv4Function(){
    ip addr | awk '/^[0-9]+: / {}; /inet.*global.*eth/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}'
}
ipv6Function(){
    ifconfig $(nvram get wan0_ifname_t) | awk '/Global/{print $3}' | awk -F/ '{print $1}'
}
ipv4=$(ipv4Function)
ipv6=$(ipv6Function)

#start Get zone identifier
zone_id=`curl -ksX GET "https://api.cloudflare.com/client/v4/zones?name=${zone_name}" -H "Authorization: Bearer ${GAK}" -H "Content-Type: application/json" | cut -b 19-50`
record_id=`curl -ksX GET "https://api.cloudflare.com/client/v4/zones/${zone_id}/dns_records" -H "Authorization: Bearer ${GAK}" -H "Content-Type: application/json" | cut -b 19-50`

#update
curl -X PUT "https://api.cloudflare.com/client/v4/zones/${zone_id}/dns_records/${record_id}" -H "Authorization: Bearer ${GAK}" -H "Content-Type: application/json" --data "{\"type\":\"AAAA\",\"name\":\"$record_name_6\",\"content\":\"$ipv6\",\"ttl\":60,\"proxied\":$proxy}"
curl -X PUT "https://api.cloudflare.com/client/v4/zones/${zone_id}/dns_records/${record_id}" -H "Authorization: Bearer ${GAK}" -H "Content-Type: application/json" --data "{\"type\":\"A\",\"name\":\"$record_name_4\",\"content\":\"$ipv4\",\"ttl\":60,\"proxied\":$proxy}"
echo -e "\n\n---------------------------------"
echo "[CloudFlare]" "${record_name_4} : ${ipv4}"
echo -e "---------------------------------\n\n"
echo "[CloudFlare]" "${record_name_6} : ${ipv6}"
echo -e "---------------------------------\n\n"
nslookup ${record_name_4}
nslookup ${record_name_6}
echo -e "\n\n---------------------------------\n\n"

