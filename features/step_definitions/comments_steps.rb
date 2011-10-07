Given /^I am logged in$/ do
  @user = Factory(:user)
end

Given /^I have (\d+) custom news article$/ do |arg1|
  Article.delete_all
  arg1.to_i.times do
    Factory :article
  end
  @article = Article.first
end

Given /^I have no comments$/ do
  Article.all.each do |article|
    article.comments.delete_all
  end
end

Given /^I have (\d+) comment for custom news article "([^"]*)"$/ do |comments_count, news_title|
  Article.delete_all
  Factory :article, :title => news_title
  @article = Article.find_by_title news_title
  @article.comments.delete_all
  comments_count.to_i.times do
    @article.comments.build(:comment => "I'm comment",:user => @user).save
  end
end

When /^I am stay on custom news path for "([^"]*)"$/ do |arg1|
  @article = Article.find_by_title arg1
end

When /^(?:|I )push "Delete comment"$/ do
  (Article.find @article.id).comments.first.delete
end

When /^(?:|I )push "Add comment"$/ do
  @article.comments.build(:comment => "I'm comment",:user => @user).save
end

When /^(?:|I )type "([^"]*)" in "Message" textarea$/ do |value|
  (Article.find @article.id).comments.first.comment = value
end

Then /^I should have no comments$/ do
  (Article.find @article.id).comments.length.should be_eql(0)
end

Then /^I should have (\d+) comment$/ do |arg1|
  (Article.find @article.id).comments.length.should be_eql(arg1.to_i)
end
