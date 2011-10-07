Given /^I am a user named "([^"]*)" and surnamed "([^"]*)" with an email "([^"]*)" and password "([^"]*)"$/ do |first_name, last_name, email, password|
  User.new(:first_name => first_name,
            :last_name => last_name,
            :email => email,
            :password => password,
            :password_confirmation => password).confirm!
end


Given /^no user exists with an email of "(.*)"$/ do |email|
  User.find(:first, :conditions => { :email => email }).should be_nil
end

Given /I'm editing my profile page$/ do
    Given %{I am logged in as user}
    When %{I follow "Edit profile"}
    Then %{I should see "Edit profile"}
end

When /^I fill in profile fields$/ do
  profile = Factory.build(:profile)
  And %{I fill in "First name" with "#{profile.first_name}"}
  And %{I fill in "Last name" with "#{profile.last_name}"}
end

Then /^I should see profile$/ do
  profile = Factory.build(:profile)
  Then %{I should see "#{profile.first_name}"}
  And %{I should see "#{profile.last_name}"}
end

Then /^I should be already signed in$/ do
  And %{I should see "Logout"}
end

Given /^I am signed up as "(.*)\/(.*)"$/ do |first_name, last_name, email, password|
  Given %{I am not logged in}
  When %{I go to the sign up page}
  And %{I fill in "First name" with "#{first_name}"}
  And %{I fill in "Last name" with "#{last_name}"}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I fill in "Password confirmation" with "#{password}"}
  And %{I press "Sign up"}
  Then %{I should see "You have signed up successfully. If enabled, a confirmation was sent to your e-mail."}
  And %{I am logout}
end

Then /^I sign out$/ do
  click_link "Logout admin" if page.has_xpath?('//*', :text => "Logout admin")
end

Given /^I am logout$/ do
  Given %{I sign out}
end

Given /^I am not logged in$/ do
  Given %{I sign out}
end

Given /^I am logged in as (.*)$/ do |role|
  @admin = Factory :admin
  Given %{I am not logged in}
  When %{I sign in as "#{@admin.email}/#{@admin.password}"}
end

When /^I sign in as "(.*)\/(.*)"$/ do |email, password|
  Given %{I am not logged in}
  When %{I go to the sign in page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Sign in"}
end

When /^I sign in as a user with wrong password$/ do
  user = Factory.build(:user)
  Given %{I am not logged in}
  When %{I go to the sign in page}
  And %{I fill in "Email" with "#{user.email}"}
  And %{I fill in "Password" with "#{user.password + 'qwerty'}"}
  And %{I press "Sign in"}
end

Then /^I should be signed in$/ do
  Then %{I should see "Logout admin"}
end

When /^I return next time$/ do
  And %{I go to the home page}
end

Then /^I should be signed out$/ do
  And %{I should see "Login admin"}
  And %{I should not see "Logout admin"}
end
