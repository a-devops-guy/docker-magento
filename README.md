# Magento 2.3 Docker Container

This is a docker compose project for magento 2 dev environment with all services like redis, varnish, ES, cron etc

# How to run?
1. Change php.ini & www.conf (fpm) conf as per your requirment on both cli magento and fpm folder. The template contains Magento recommender configs. You can chnage if you want to customize furthur
2. change ES jvm memory as per your requirement unde ES7/jvm.options
3. Change access key to download magento using composer in auth.json. Ref magento doc on how to get access keys. (docker compose wont work unless you perform this step)
4. Add entry to locahost with DNS www.magento-dev.com
5. run docker compose

# This will set up the end to end magento 2.3 service for development. Later you can git pull change to magento folder located under /var/www/html/magento

# Default Credentials for services
1. Magento Backend - http://www.magento-dev.com/admin - magento:Magento@123
2. DB - hostname(mysql) - magento:magento - DB name (magento)
3. Redis - hostname(Redis) - No Credential
4. ES - hostname(ES) - No Credentila
5. RabbitMq: - Hostname(rmq) - guest:guest

# Note: to use ES service you have to log into backend to use the service. As magento 2.3 doesnt include cli to use ES7 service

# refer branch mage2.4 to use magento 2.4 service
# most of the variables are hardcoded. As this is for test env. raise an issue if anything. 