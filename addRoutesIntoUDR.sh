#!/bin/bash

# 実行環境に合わせて変更
subscription="Azure 社内従量課金プラン No.1"
resourcegroup="AppGW-rg"
routetable="UDR2"

# Azure login and set active subscription
az login
az account set --subscription $subscription

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