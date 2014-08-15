<?php

use SensioLabs\Behat\PageObjectExtension\Context\PageObjectContext;

class CustomerContext extends PageObjectContext
{
    private $customer;

    /**
     * @Given /^I have a customer$/
     */
    public function iHaveACustomer()
    {
        $this->customer = $this->getMainContext()
            ->getManager()
            ->loadFixture('customer/customer');
    }

    /**
     * @When /^I login in with a customer$/
     */
    public function iLoginInWithACustomer()
    {
        $this->getPage('Customer\Login')->open()
            ->customerLogin($this->customer->getEmail(), $this->customer->getPassword());
    }

    /**
     * @Then /^I should see the customers email$/
     */
    public function iShouldSeeTheCustomersEmail()
    {
        $webAssert = $this->getMainContext()->getWebAssert();
        $webAssert->pageTextContains($this->customer->getEmail());
    }


}