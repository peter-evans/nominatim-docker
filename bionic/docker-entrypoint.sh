#!/bin/bash

# Defaults
NOMINATIM_DATA_PATH=${NOMINATIM_DATA_PATH:="/srv/nominatim/data"}
NOMINATIM_DATA_LABEL=${NOMINATIM_DATA_LABEL:="data"}
NOMINATIM_PBF_URL=${NOMINATIM_PBF_URL:="http://download.geofabrik.de/asia/maldives-latest.osm.pbf"}


# Retrieve the PBF file
if [ -z "${NOMINATIM_PBF_FILE_NAME}"] 
then
	curl -L $NOMINATIM_PBF_URL --create-dirs -o $NOMINATIM_DATA_PATH/$NOMINATIM_DATA_LABEL.osm.pbf && chmod 755 $NOMINATIM_DATA_PATH
fi
# Start PostgreSQL
service postgresql start

# Import data
sudo -u postgres psql postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='nominatim'" | grep -q 1 || sudo -u postgres createuser -s nominatim
sudo -u postgres psql postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='www-data'" | grep -q 1 || sudo -u postgres createuser -SDR www-data
sudo -u postgres psql postgres -c "DROP DATABASE IF EXISTS nominatim"
useradd -m -p password1234 nominatim
if [ -z "${NOMINATIM_PBF_FILE_NAME}"] 
then
	sudo -u nominatim /srv/nominatim/build/utils/setup.php --osm-file $NOMINATIM_DATA_PATH/$NOMINATIM_DATA_LABEL.osm.pbf --all --threads 2
else
	sudo -u nominatim /srv/nominatim/build/utils/setup.php --osm-file /nominatimdata/$NOMINATIM_PBF_FILE_NAME --all --threads 2
fi

# Tail Apache logs
tail -f /var/log/apache2/* &

# Run Apache in the foreground
/usr/sbin/apache2ctl -D FOREGROUND
