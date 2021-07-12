#!/bin/sh
# Author : Zenika Bordeaux
# Date : 12-07-2021
# Goal : Deploy & Config Application Monitoring
##############################################################################

#!/bin/sh


pathMain="/tmp/"

# Creating main paths
[ -d $pathMain/graylog ] || mkdir -p $pathMain/graylog/config


# Copy Configuration Files in Directories
cp docker-compose.yml $pathMain/graylog/docker-compose.yml
cp monitoring_manager.sh $pathMain/graylog/monitoring_manager.sh

cp config/graylog.conf $pathMain/graylog/config/graylog.conf
cp config/log4j2.xml $pathMain/graylog/config/log4j2.xml


# Full Permissions
# Containers need to write in "mode-id file" in $pathMain/graylog/config
chmod -R 777 $pathMain/graylog

# Start Monitoring
docker-compose -f $pathMain/graylog/docker-compose.yml up -d

sleep 10

docker cp graylogctl graylog:/usr/share/graylog/bin/graylogctl

docker restart graylog
