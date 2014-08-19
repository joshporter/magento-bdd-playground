#!/usr/bin/env bash

#need this to get 'libapache2-mod-fastcgi'
sudo sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list
sudo apt-get update

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

sudo apt-get install -y curl apache2 libapache2-mod-fastcgi php5 php5-fpm php5-cli php5-curl php5-gd php5-mcrypt php5-mysql mysql-server

sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/fpm/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/fpm/php.ini
sudo sed -i "s/disable_functions = .*/disable_functions = /" /etc/php5/cli/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 1024M/" /etc/php5/fpm/php.ini
sudo sed -i "s#date\.timezone.*#date\.timezone = \"Europe\/London\"#" /etc/php5/fpm/php.ini

sudo a2enmod rewrite actions fastcgi alias

sudo bash -c "cat >> /etc/apache2/conf.d/servername.conf <<EOF
ServerName localhost
EOF"

WEBROOT="/vagrant/public"
sudo echo "<VirtualHost *:80>
  DocumentRoot $WEBROOT

  <Directory $WEBROOT>
    Options FollowSymLinks MultiViews ExecCGI
    AllowOverride All
    Order deny,allow
    Allow from all
  </Directory>

  <IfModule mod_fastcgi.c>
    AddHandler php5-fcgi .php
    Action php5-fcgi /php5-fcgi
    Alias /php5-fcgi /usr/lib/cgi-bin/php5-fcgi
    FastCgiExternalServer /usr/lib/cgi-bin/php5-fcgi -host 127.0.0.1:9000 -pass-header Authorization
  </IfModule>

</VirtualHost>" | sudo tee /etc/apache2/sites-available/default > /dev/null

sudo service apache2 restart
sudo service php5-fpm restart

#Install Magento CE 1.8.1
mysql -uroot -proot -e "SET PASSWORD = PASSWORD('');"
echo 'Installing Magento sample data...'
wget -O magento-sample-data-1.6.1.0.tar.gz http://www.magentocommerce.com/downloads/assets/1.6.1.0/magento-sample-data-1.6.1.0.tar.gz 2> /dev/null
tar -xzf magento-sample-data-1.6.1.0.tar.gz
mysql -uroot -e 'CREATE DATABASE 'magento';'
mysql -uroot magento < magento-sample-data-1.6.1.0/magento_sample_data_for_1.6.1.0.sql
rm -rf magento-sample-data-1.6.1.0*

php -f /vagrant/public/install.php -- --license_agreement_accepted yes --locale en_GB --timezone Europe/London --default_currency GBP --db_host localhost --db_name magento --db_user root --db_pass "" --url http://magento-bdd.dev/ --skip_url_validation yes --use_rewrites yes --use_secure no --secure_base_url http://magento-bdd.dev/ --use_secure_admin no --admin_firstname admin --admin_lastname admin --admin_email admin@example.com --admin_username admin --admin_password 123123pass

sudo bash -c "cat >> /etc/hosts <<EOF
127.0.0.1 magento-bdd.dev
EOF"

#Install PhantomJS
cd /usr/local/share
sudo wget https://phantomjs.googlecode.com/files/phantomjs-1.9.2-linux-i686.tar.bz2
sudo tar xjf phantomjs-1.9.2-linux-x86_64.tar.bz2
sudo ln -s /usr/local/share/phantomjs-1.9.2-linux-i686/bin/phantomjs /usr/local/share/phantomjs; sudo ln -s /usr/local/share/phantomjs-1.9.2-linux-i686/bin/phantomjs /usr/local/bin/phantomjs; sudo ln -s /usr/local/share/phantomjs-1.9.2-linux-i686/bin/phantomjs /usr/bin/phantomjs
sudo rm phantomjs-1.9.2-linux-i686.tar.bz2