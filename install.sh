#!/bin/bash

# Automatize drupal with drush instalation and enable debugging
# USAGE:
#    ./install.sh project_name db_user db_password

# Drush input data
NAMESPACE=${1}
DBUSER=${2}
DBPWD=${3}
DBNAME=${1//\-/_}
SITENAME=${1//\-/_}
SITEMAIL="admin@example.com"

# Create drush alias
ROOT=`pwd`
drush="$ROOT/vendor/drush/drush/drush"
cd web

# Install site
$drush site-install --db-url="mysql://$DBUSER:$DBPWD@localhost/$DBNAME" --account-name=admin --account-pass=admin standard -y

# Copy developement files
chmod +w sites/default
chmod +w sites/default/settings.php
cp sites/example.settings.local.php sites/default/settings.local.php
printf "\$config_directories['staging'] = '../config_staging';" >> sites/default/settings.php
printf "\nif (file_exists(\$app_root . '/' . \$site_path . '/settings.local.php')) {\n
  include \$app_root . '/' . \$site_path . '/settings.local.php';\n}\n" >> sites/default/settings.php
chmod -w sites/default/settings.php
chmod -w sites/default

# Fix for drush config import 
# See: https://www.drupal.org/node/2583113#comment-11333793
$drush ev '\Drupal::entityManager()->getStorage("shortcut_set")->load("default")->delete();'
$drush pmu shortcut -y


# If there is configuration directory
if [ -d "$ROOT/config_staging/" ]; then
    # Store and set uuid  
    uuid=`cat ../config_staging/system.site.yml |awk '/uuid: /{print $NF}'`
    $drush config-set "system.site" uuid $uuid -y

    # Import configuration
    $drush config-import staging -y
fi