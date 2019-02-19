 #!/bin/sh
 bundle exec whenever --write-crontab --set environment=production
 cron -f
