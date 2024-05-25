#!/bin/bash

mkdir -p ./pbr
cd ./pbr

# AS4809 BGP
wget --no-check-certificate -c -O custom-proxy-ip.txt https://raw.githubusercontent.com/fillpit/script/main/clash/rules/custom-proxy-ip.txt

{
echo "/ip firewall address-list"

# 读取 custom-proxy-ip.txt 文件
while read -r line; do
    # 如果行不为空且不以 # 开头
    if [[ -n "${line}" ]] && [[ "${line}" != "#"* ]]; then
        # 输出该行
        echo "add list=DO_PROXY_IP address=${line} comment=do_proxy_ip"
    fi
done < custom-proxy-ip.txt

cd ..
rm -rf ./pbr
