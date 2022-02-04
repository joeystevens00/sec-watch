echo -e "$(env)\n$(cat daily.crontab)" > app.crontab
crontab app.crontab
cron -f