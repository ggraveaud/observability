#!/bin/sh
# Author : geoffrey.graveaud@zenika.com
# Date : 12-07-2021
# Goal : Deploy & Config Container Monitoring
##############################################################################

#!/bin/sh


pathMain="/tmp"

# Creating  paths
[ -d $pathMain/grafana ] || mkdir $pathMain/grafana
[ -d $pathMain/grafana/data ] || mkdir $pathMain/grafana/data
[ -d $pathMain/grafana/provisioning ] || mkdir $pathMain/grafana/provisioning
[ -d $pathMain/grafana/provisioning/datasources ] || mkdir $pathMain/grafana/provisioning/datasources
[ -d $pathMain/grafana/provisioning/dashboards ] || mkdir $pathMain/grafana/provisioning/dashboards
[ -d $pathMain/grafana/dashboards ] || mkdir $pathMain/grafana/dashboards
[ -d $pathMain/prometheus ] || mkdir $pathMain/prometheus
[ -d $pathMain/alertmanager ] || mkdir $pathMain/alertmanager

# Creating monitoring path
[ -d $pathMain/monitoring ] || mkdir $pathMain/monitoring


# Copy Configuration Files in Directories
cp docker-compose.yml $pathMain/monitoring/docker-compose.yml
cp monitoring_manager.sh $pathMain/monitoring/monitoring_manager.sh

cp alertmanager/config.yml $pathMain/alertmanager/config.yml
cp prometheus/prometheus.yml $pathMain/prometheus/prometheus.yml
cp prometheus/alert.rules $pathMain/prometheus/alert.rules

cp grafana/dashboards/*.json $pathMain/grafana/dashboards
cp grafana/provisioning/dashboards/db_prov.yml $pathMain/grafana/provisioning/dashboards/db_prov.yml
cp grafana/provisioning/datasources/ds_prov.yml $pathMain/grafana/provisioning/datasources/ds_prov.yml


# Permissions
chmod 755 $pathMain/monitoring/monitoring_*.sh


# Start Monitoring
docker-compose -f $pathMain/monitoring/docker-compose.yml up -d

# Suggest configuration for alertmanager & sendmail.
alertIP=$(docker inspect monitoring_alertmanager --format '{{.NetworkSettings.Networks.monitoring_default.IPAddress}}')
echo ""
echo "Please configure Sendmail for alerting "
echo "Use AlertManager IP: $alertIP"
