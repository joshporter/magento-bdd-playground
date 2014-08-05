Magento BDD Playground
===
[![Build Status](https://travis-ci.org/joshporter/magento-bdd-playground.svg?branch=master)](https://travis-ci.org/joshporter/magento-bdd-playground)

Magento CE 1.8.1 (1.9 sample data is massive). Install behat and phpspec with relevant extensions.

```bash
composer install
cd tools
vagrant up
```

Add following line to `/etc/hosts`:
```bash
192.168.50.50 magento-bdd.dev
```

To run tests, need to be inside of VM

```bash
cd tools
vagrant ssh
cd /vagrant
bin/phpspec r && bin/behat
```
