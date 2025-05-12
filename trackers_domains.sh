#!/bin/bash

# 定义文件的下载链接和输出文件
download_url="https://cf.trackerslist.com/all.txt"
output_file="./clash/rules/trackers_domains.txt"


# 下载文件，跳过 SSL 证书验证
echo "正在从 $download_url 下载 all.txt 文件..."
wget --no-check-certificate -O all.txt "$download_url"

# 检查下载是否成功
if [ $? -ne 0 ]; then
  echo "下载失败，请检查链接是否正确或网络连接是否正常！"
  exit 1
fi

echo "下载完成，开始处理文件..."

# 提取域名部分并去掉端口号，过滤掉 IP 地址，然后去重
awk -F/ '{
  # 提取域名部分（包括端口号）
  domain_port = $3
  # 去掉端口号（如果存在）
  sub(/:[0-9]+$/, "", domain_port)
  # 过滤掉 IPv4 和 IPv6 地址
  if (domain_port !~ /^(\[[0-9a-fA-F:]+\]|[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)$/) {
    print domain_port
  }
}' all.txt | sort -u > "$output_file"

# 删除下载的临时文件
rm all.txt

echo "处理完成，去重后的域名已保存到 $output_file"
