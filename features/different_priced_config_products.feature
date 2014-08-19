Feature: Due to different clothes size's of clothes having varying costs
  As a store owner
  I want different sizes of the same product to have a different price

  @javascript
  Scenario: Dresses of 3 sizes has varying prices
    Given I have a configurable product
    When I visit the configurable product
    Then the following options should have associated price:
      | label | price |
      | Green | 20    |
      | Blue  | 15    |
      | Black | 10    |