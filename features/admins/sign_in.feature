Feature: Sign in
  In order to get access to protected sections of the site
  A user
  Should be able to sign in

    Scenario: User is not signed up
      Given I am not logged in
      And no user exists with an email of "user@test.com"
      When I go to the sign in page
      And I sign in as "user@test.com/please"
      And I go to the home page
      Then I should be signed out

    Scenario: Admin signs in successfully with email
      Given I am not logged in
      And I am logged in as admin
      Then I should be signed in
