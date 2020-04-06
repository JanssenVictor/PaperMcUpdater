<b>Auto updater for PaperMc</b>

This simple bash script check if your server is online and notifies you of updates on Slack.

<b>install:</b>

-make sure jq is installed:

```sudo apt-get install jq```

-make sure netcat(nc) is installed:

```sudo apt-get install netcat```

-make sure curl is installed:

```sudo apt-get install curl```


<b>Edits to make to update.sh:</b>

-create a txt file called currentpaperversion.txt in your PaperMc server root (where your paperclip.jar is).

-change {server-ip} with your server ip.

-change {server-path} to your PaperMc root.

-change {minecraft-version} to your server's minecraft version. (e.g. 1.15.2)

-change {slack-webhook-url} to your Slack incoming webhook url.

<b>For best results:</b>

use Cron to execute this script every X amount of time.
