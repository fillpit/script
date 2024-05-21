#!/bin/sh
mkdir -p ./pbr
cd ./pbr

# AS4809 BGP
wget --no-check-certificate -c -O custom-direct-ip.txt https://raw.githubusercontent.com/fillpit/script/main/clash/rules/custom-direct-ip.txt

{
echo "/ip firewall address-list"

ignore = "#"
for net in $(cat custom-direct-ip.txt) ; do
  if [[ $net != *$ignore* ]]; then
      echo "add list=CN address=$net comment=custom ip"
  fi
done

} > ../RouterOS/custom-direct-ip.rsc

cd ..
rm -rf ./pbr
