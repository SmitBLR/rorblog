require 'spec_helper'

describe Comment do
  before :each do
    @comment = Factory :comment
  end

  it "comment's body should not be nil" do
    @comment.comment = nil
    @comment.should_not be_valid
    @comment.error_on(:comment).should_not be_nil
  end

  it "length of comment's body should be valid" do
    @comment.comment = ""
    @comment.should_not be_valid
  end
end
