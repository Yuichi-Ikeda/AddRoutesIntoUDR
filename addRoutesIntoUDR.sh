#!/bin/bash

# 実行環境に合わせて変更
subscriptionID="xx0000x0-xx00-0000-0x00-0x0x0xxxxx0x"
resourcegroup="AppGW-rg"
routetable="UDR"

# Azure login and set active subscription
az login
az account set --subscription $subscriptionID

# Add routes from IP list. 
count=0
while read row; do
  count=`expr $count + 1`
  index=`(printf "GM_%03d" "${count}")`
  # IP アドレスのダブルクォーテーションを削除
  address=`echo $row | sed 's/^.*"\(.*\)".*$/\1/'`
  echo "$index $address"

  az network route-table route create --address-prefix $address --name $index --next-hop-type Internet --resource-group $resourcegroup --route-table-name $routetable
done < 0.txt