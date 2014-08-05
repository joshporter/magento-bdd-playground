Feature: In order to test customer attributes
  As a store owner
  I want to see customer

  Scenario: Test customer exists
    Given I have a customer
    When I login in with a customer
    Then I should see the customers email