#!/bin/bash
for dir in */
do
  if [[ $dir = 'tests/' ]];
  then
    continue
  fi
  for os_version in "$dir"/*
  do
    cp docker-entrypoint.sh "$os_version"
    cp local.php "$os_version"
    cp nominatim.conf "$os_version"
  done
done
