#!/bin/sh
set -e

#install magento
echo Y | composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=2.4.2 magento

mkdir -p /var/www/html/magento/var/composer_home/
ln -sf /root/.composer/auth.json /var/www/html/magento/var/composer_home/auth.json

#permission apply for folders 
cd /var/www/html/magento && \
    find . -type f -exec chmod 644 {}  && \
    find . -type d -exec chmod 755 {}  && \
    chmod 644 ./app/etc/*.xml && \
    chown -R :www-data . && chmod u+x /bin/magento && \
    umask 022

#magento command line install 
php /var/www/html/magento/bin/magento setup:install --base-url=http://www.magento-dev.com/ \
--db-host=mysql --db-name=magento --db-user=magento --db-password=magento \
--admin-firstname=Magento --admin-lastname=User --admin-email=user@example.com \
--admin-user=magento --admin-password=Magento@123 --language=en_US \
--currency=USD --timezone=America/Chicago --use-rewrites=1 --backend-frontname=admin \
--http-cache-hosts=varnish:6081 \
--cache-backend=redis --cache-backend-redis-server=redis --cache-backend-redis-db=0 \
--page-cache=redis --page-cache-redis-server=redis --page-cache-redis-db=1 \
--session-save=redis --session-save-redis-host=redis --session-save-redis-log-level=4 --session-save-redis-db=2 \
--amqp-host="rabbitmq" --amqp-port="5672" --amqp-user="guest" --amqp-password="guest" --amqp-virtualhost="/" \
--search-engine=elasticsearch7 --elasticsearch-host=es --elasticsearch-port=9200

# #varnish conf
php /var/www/html/magento/bin/magento config:set --scope=default --scope-code=0 system/full_page_cache/caching_application 2

#cron install
php /var/www/html/magento/bin/magento cron:install

#if docker env INSTALL_SAMPLE_DATA = true; install sample data else skip
if [[ $INSTALL_SAMPLE_DATA = true ]]
then
    php /var/www/html/magento/bin/magento sampledata:deploy
    php /var/www/html/magento/bin/magento setup:upgrade
else
  echo "Skipping Sample Data Install"
fi

#final touch
php /var/www/html/magento/bin/magento cache:flush
php /var/www/html/magento/bin/magento cache:clean
php /var/www/html/magento/bin/magento indexer:reindex
php /var/www/html/magento/bin/magento deploy:mode:set developer

exec "$@"