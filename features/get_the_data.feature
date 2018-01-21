Feature: I can get the data
  Background:

    @javascript @pending @wip
  Scenario: First data file is retrievable
    Given I visit the app root
    And I see a list of links
    When I follow the first link
    Then I see a well-formed CSV document
    And the CSV has a consistent number of columns throughout
    And the number of columns is not zero

    @javascript @pending
  Scenario: All listed data files are retrievable
    Given I visit the app root
    And I see a list of links
    When I follow the rest of the links and collect their CSV
    Then each of my CSVs are well-formed CSV document
    And each of my CSVs has a consistent number of columns throughout
    And each of my CSVs has a number of columns that is not zero

