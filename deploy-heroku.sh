#!/bin/bash

ROOT=`pwd`
drush="$ROOT/vendor/drush/drush/drush"

# Install site
$drush site-install --db-url=pgsql://$USER:$PASSWORD@$HOST:$PORT/$DATABASE --account-name=admin --account-pass=admin standard -y

ROOT=`pwd`
drupal="$ROOT/vendor/drupal/console/bin/drupal"
cd web

#drupal site:install  standard  \
#--langcode="en"  \
#--db-type="pgsql"  \
#--db-host="$HOST"  \
#--db-name="$DATABASE"  \
#--db-user="$USER"  \
#--db-pass="$PASSWORD"  \
#--db-port="$PORT"  \
#--site-name="Drupal 8 Restful Testing"  \
#--site-mail="admin@example.com"  \
#--account-name="admin"  \
#--account-mail="admin@example.com"  \
#--account-pass="admin"

# Fix for drush config import
# See: https://www.drupal.org/node/2583113#comment-11333793

#$drush ev '\Drupal::entityManager()->getStorage("shortcut_set")->load("default")->delete();'
#$drush pmu shortcut -y


#if [ -d "$ROOT/config_staging/" ]; then
#    uuid=`cat ../config_staging/system.site.yml |awk '/uuid: /{print $NF}'`
#    $drush config-set "system.site" uuid $uuid -y
#    $drush config-import staging -y
#fi