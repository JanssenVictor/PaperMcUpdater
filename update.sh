#!/bin/bash

#get latest build number.
latestversion=$(curl -sS https://papermc.io/api/v1/paper/{minecraft-version}/latest  | jq -r '.build')

#get currently installed build number.
currentversion=$(cat {server-path}/currentpaperversion.txt)

#set slack webhook url.
slack-webhook-url=https://hooks.slack.com/services/XXXXXXXXX/XXXXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXX

#check if server is online
nc -v -z -w2 {server-ip} 25565 &> /dev/null;

#if server is online, check for updates
if [ $? -eq 1 ]; then
  #if latest version matches installed version, do nothing.
  if [ $latestversion -eq $currentversion ]; then
    :
     #update if neccesary and notify.
  else
      rm {server-path}/paperclip.jar
      if [ $? -eq 0 ]; then
        wget -P {server-path} https://papermc.io/ci/job/Paper-1.15/lastSuccessfulBuild/artifact/paperclip.jar
        if [ $? -eq 0 ]; then
          echo "$latestversion" > "{server-path}/currentpaperversion.txt"
          text="UPDATE SUCCESFULL \nServer updated from $currentversion to $latestversion"
          json="{\"text\": \"$text\"}"
          curl -s -d "payload=$json"  "{slack-webhook-url}"
        fi
      fi
  fi
  #server is online, check for new version and notify is new version is available.
else
  if [ $latestversion -eq $currentversion ]; then
    :
  else
    text="NEW VERSION of paper is available but server is online. \nYou are running $currentversion but latest = $latestversion"
    json="{\"text\": \"$text\"}"
    curl -s -d "payload=$json"  "{slack-webhook-url}"
  fi
fi
