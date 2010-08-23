Feature: Manage presentations
  In order to show Organizations and everything else
  As a regular user
  wants see what I got
  
  Scenario: Data List
    Given I have two organizations created named Bank, Store
    When I go to the lists of Organizations and Strategies
    Then I should see the organizations allowed
    And the Strategies allowed