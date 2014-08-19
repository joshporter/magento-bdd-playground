<?php

use MageTest\MagentoExtension\Context\RawMagentoContext;
use MageTest\Manager\Attributes\Provider\YamlProvider;
use MageTest\Manager\FixtureManager;

/**
 * Features context.
 */
class FeatureContext extends RawMagentoContext
{
    /* @var \MageTest\Manager\FixtureManager */
    private $manager;

    public function __construct()
    {
        $this->useContext('customer', new CustomerContext());
        $this->useContext('config_product', new ConfigProductContext());
    }

    /**
     * @BeforeScenario
     */
    public function before()
    {
        $this->manager = new FixtureManager(new YamlProvider());
    }

    /**
     * @AfterScenario
     */
    public function after()
    {
        $this->manager->clear();
        $this->manager = null;
    }

    public function getManager()
    {
        return $this->manager;
    }

    public function getWebAssert()
    {
        return $this->getMink()->assertSession();
    }
}