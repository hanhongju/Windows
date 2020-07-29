#cloudflare api dns记录维护@Debian 10
#安装依赖
apt  update
apt  install   -y   curl

#定义cloudflare api参数
email=86606682@qq.com
api_key=0e4c326d547e60c8901491fec0bbbfe6b8f84
zone_id=5bb519b973ac6d3df07806e97bc958df
domain=rmrf.hongju.xyz
dynamic_ip=`curl ip.sb`
ttl=120


<<EOF

#创建域名对应IP记录
curl -X POST "https://api.cloudflare.com/client/v4/zones/${zone_id}/dns_records" \
-H "X-Auth-Email: ${email}" \
-H "X-Auth-Key: ${api_key}" \
-H "Content-Type: application/json" \
--data '{"type":"A", "name":"'${domain}'", "content":"'${dynamic_ip}'", "ttl":'${ttl}', "proxied":false}'

EOF



#获取record_id参数
record=`curl -X GET "https://api.cloudflare.com/client/v4/zones/${zone_id}/dns_records" \
-H "X-Auth-Email: ${email}" \
-H "X-Auth-Key: ${api_key}" \
-H "Content-Type: application/json" `
record_id=`echo ${record} | grep "id" | awk      -F     '"'     '{print $6}'`
echo   ${record_id}
#更新记录
curl -X PUT "https://api.cloudflare.com/client/v4/zones/${zone_id}/dns_records/${record_id}" \
-H "X-Auth-Email: ${email}" \
-H "X-Auth-Key: ${api_key}" \
-H "Content-Type: application/json" \
--data '{"type":"A", "name":"'${domain}'", "content":"'${dynamic_ip}'", "ttl":'${ttl}', "proxied":false}'







