#!/usr/bin/env bash

worker="[program:worker-"$2"]
command=php artisan queue:listen --sleep=3 --quiet --tries=3
directory="$1"
autostart=true
autorestart=true
user=vagrant
redirect_stderr=true
stdout_logfile=/home/vagrant/.workers/worker-"$2".log
"

echo "$worker" > "/etc/supervisor/conf.d/worker-$2.conf"

# Make worker log directory
if [ ! -d /home/vagrant/.workers ]; then
    mkdir /home/vagrant/.workers
fi

# Reload supervisor configs
supervisorctl reread
supervisorctl update
