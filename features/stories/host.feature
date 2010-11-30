@host
Feature: Hosting an event

  As a host of an event
  In order to organize it properly
  I want to create an event page


  Scenario: Host creates event page
    Given I am on the homepage

    When I fill in "event_name" with "PARTY!"
    And I fill in "event_location" with "my place"
    And I fill in "event_date" with "tomorrow"
    And I press "Create event page"

    Then I should see "Guest list"