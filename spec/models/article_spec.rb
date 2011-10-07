require 'spec_helper'

describe Article do

  before(:each) do
    @valid_article_attributes = {
        :title => 'Some title',
        :content => 'Some text',
    }
    @article = Article.new
  end

  it "should be valid" do
    @article.attributes = @valid_article_attributes
    @article.should be_valid
  end

  it "should not be valid without something to attach to" do
    c = @valid_article_attributes
    c.delete :title
    c.delete :content
    @article.attributes = c
    @article.should_not be_valid
    @article.error_on(:title).should eql(["can't be blank"])
    @article.title = 'Some title'
    @article.should_not be_valid
    @article.error_on(:content).should eql(["can't be blank"])
    @article.content = "Some text"
    @article.should be_valid
  end

  it "should attach new tag names to himself" do
    original_tags_count = Tag.all.count
    tags = "I Go To School"
    @article.tag_names = tags
    Tag.all.count.should be_eql(original_tags_count + tags.split.count)
  end
end
