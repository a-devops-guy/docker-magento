## Magento 2.4 Docker

This is a docker compose project for magento 2 dev environment with all services like redis, varnish, ES, cron etc

### How to run?
1. Change php.ini & www.conf (fpm) conf as per your requirment on both cli magento and fpm folder. The template contains Magento recommender configs. You can chnage if you want to customize furthur
2. change ES jvm memory as per your requirement unde ES7/jvm.options
3. Change access key to download magento using composer in auth.json. Ref magento doc on how to get access keys. (docker compose wont work unless you perform this step)
4. Add entry to locahost with DNS www.magento-dev.com
5. run docker compose

### This will set up the end to end magento 2.4 service for development. Later you can git pull your code to magento folder located under /var/www/html/magento

### Default Credentials for services
1. Magento Backend - http://www.magento-dev.com/admin - magento:Magento@123
2. DB - hostname(mysql) - magento:magento - DB name (magento)
3. Redis - hostname(Redis) - No Credential
4. ES - hostname(ES) - No Credentila
5. RabbitMq: - Hostname(rmq) - guest:guest

### refer branch master to use magento 2.3 service
### most of the variables are hardcoded. As this is for test env. raise an issue if anything. 