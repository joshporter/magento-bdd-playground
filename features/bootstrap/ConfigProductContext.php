<?php

use Behat\Behat\Exception\PendingException;
use Behat\Gherkin\Node\TableNode;
use SensioLabs\Behat\PageObjectExtension\Context\PageObjectContext;

class ConfigProductContext extends PageObjectContext
{
    private $configProduct;

    /**
     * @Given /^I have a configurable product$/
     */
    public function iHaveAConfigurableProduct()
    {
        $this->configProduct = $this->getMainContext()
            ->getManager()
            ->loadFixture('catalog/product/configurable', __DIR__ . '/Fixtures/Configurable.yml');
    }

    /**
     * @When /^I visit the configurable product$/
     */
    public function iVisitTheConfigurableProduct()
    {
        $this->getPage('Product\Configurable')->open(array(
            "id" => $this->configProduct->getId()
        ));
    }

    /**
     * @Then /^the following options should have associated price:$/
     */
    public function theFollowingOptionsShouldHaveAssociatedPrice(TableNode $table)
    {
        $configPage = $this->getPage('Product\Configurable');

        //TODO magento js options
        $hash = $table->getHash();
        foreach ($hash as $row) {
            $row['label'];
            $row['price'];
        }
    }

}