#!/bin/bash

ROOT=`pwd`
drush="$ROOT/vendor/drush/drush/drush"

# Install site (Not working, have to be done by interface)
# $drush site-install --db-url=pgsql://$USER:$PASSWORD@$HOST:$PORT/$DATABASE --account-name=admin --account-pass=admin standard -y

# Fix for drush config import
# See: https://www.drupal.org/node/2583113#comment-11333793

#$drush ev '\Drupal::entityManager()->getStorage("shortcut_set")->load("default")->delete();'
#$drush pmu shortcut -y


#if [ -d "$ROOT/config_staging/" ]; then
#    uuid=`cat ../config_staging/system.site.yml |awk '/uuid: /{print $NF}'`
#    $drush config-set "system.site" uuid $uuid -y
#    $drush config-import staging -y
#fi