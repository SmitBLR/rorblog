Feature: Comments management for custom news.

  Scenario: Logged in users can add comments for custom news
    Given I am logged in
    And I have 1 custom news article
    And I have no comments
    When I push "Add comment"
    And I type "Nice article!" in "Message" textarea
    Then I should have 1 comment

  Scenario: Logged in users can delete their comments
    Given I am logged in
    And I have 1 comment for custom news article "Ruby rocks"
    When I am stay on custom news path for "Ruby rocks"
    And I push "Delete comment"
    Then I should have no comments
