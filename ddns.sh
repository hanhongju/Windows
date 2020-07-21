#下载文件
wget    https://raw.githubusercontent.com/nanqinlang-script/CloudFlare_DNS_Record/Setter/CloudFlare_DDNS_Setter.sh     -cP   /home/CloudFlare_DDNS
wget    https://raw.githubusercontent.com/nanqinlang-script/CloudFlare_DNS_Record/Setter/config.conf                   -cP   /home/CloudFlare_DDNS
#写入配置文件，修改DNS
echo  "
email=86606682@qq.com
zone_id=5bb519b973ac6d3df07806e97bc958df
api_key=0e4c326d547e60c8901491fec0bbbfe6b8f84
record_id=772ef0e8ca7fd2f67aa9f016b2cedbbf
domain=rmrf.hongju.xyz
ttl=120
"       >      /home/CloudFlare_DDNS/config.conf
bash    /home/CloudFlare_DDNS/CloudFlare_DDNS_Setter.sh     --ddns
#每5分钟修改一次DNS
echo       "
*/5 * *  * *   bash    /home/CloudFlare_DDNS/CloudFlare_DDNS_Setter.sh     --ddns
"  |  crontab
crontab    -l
service   cron   restart
#完成
