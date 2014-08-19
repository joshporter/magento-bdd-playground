<?php

namespace Page\Product;

use SensioLabs\Behat\PageObjectExtension\PageObject\Page;

class Configurable extends Page
{
    protected $path = '/catalog/product/view/id/{id}';
}