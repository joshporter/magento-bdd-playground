<?php

namespace Page\Customer;

use SensioLabs\Behat\PageObjectExtension\PageObject\Page;

class Login extends Page
{
    protected $path = 'customer/account/login';

    public function customerLogin($email, $password)
    {
        $this->fillField('Email Address', $email);
        $this->fillField('Password', $password);
        $this->pressButton('Login');
    }
}