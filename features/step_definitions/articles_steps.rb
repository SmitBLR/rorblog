Given /^article exists with title: (.+) with content (.+)$/ do |title, content|
  Article.create!(:title => title, :content => content)
end

When /^I follow "(.+)" page$/ do |title|
  visit article_path(Article.find_by_title(title).id)
end

Given /^there are no article articles$/ do
  Article.delete_all
end

When /^I follow edit article page for (.+)$/ do |title|
  visit edit_article_path(Article.find_by_title(title))
end


