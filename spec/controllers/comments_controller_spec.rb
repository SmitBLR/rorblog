require 'spec_helper'

describe CommentsController do

  before :each do
    @comment = Factory(:comment)
  end

  describe  "as signed in admin" do

    before :each do
      sign_in Factory(:admin)
    end

    it "should render edit template on edit action" do
      xhr :get, :edit, { :id => @comment }
      response.should render_template "comments/edit"
    end

    it "should render update template on update action by ajax" do
      xhr :get, :update, { :id => @comment, :comment => { :comment => "new text" }, :article_id => @comment.commentable_id }
      response.should render_template "comments/update"
    end

    it "should update comment on update action by ajax" do
      original_comment = @comment.comment
      xhr :get, :update, { :id => @comment, :comment => { :comment => "new text" }, :article_id => @comment.commentable_id }
      Comment.find(@comment.id).comment.should_not be_eql original_comment
    end

    it "should not update comment on update action by ajax with invalid comment's comment" do
      original_comment = @comment.comment
      xhr :get, :update, { :id => @comment, :comment => { :comment => "" }, :article_id => @comment.commentable_id }
      Comment.find(@comment).comment.should be_eql original_comment
    end

    it "should render destroy template on destroy action by ajax" do
      xhr :get, :destroy, { :id => @comment }
      response.should render_template "comments/destroy"
    end

    it "should delete the comment on destroy action by ajax" do
      xhr :get, :destroy, :id => @comment
      Comment.exists?(@comment).should be_false
    end

    it "should render create template on create action by ajax" do
      xhr :get, :create, :comment => { :comment => "I'm a Test comment"}, :article_id => @comment.commentable.id
      response.should render_template "comments/create"
    end

    it "should create comment on create action by ajax" do
      comments_count = Comment.all.length
      xhr :get, :create, :comment => { :comment => "I'm a Test comment"}, :article_id => @comment.commentable.id
      comments_count.should_not be_eql Comment.all.length
    end

    it "can't create a comment if comment is invalid on create action by ajax" do
      comments_count = Comment.all.length
      xhr :get, :create, :comment => { :comment => ""}, :article_id => @comment.commentable.id
      comments_count.should be_eql Comment.all.length
    end

    it "should not access to update commentable_id for comment" do
      stranger_article = Factory :article
      original_news = @comment.commentable_id
      xhr :get, :update, :id => @comment, :comment => { :comment => "I'm updated comment", :commentable_id => stranger_article.id }, :article_id => @comment.commentable.id
      original_news.should be_eql Comment.find(@comment.id).commentable_id
    end

    it "should not access to update owner for comment" do
      stranger_user = Factory(:user, :email => "user2@test.com")
      original_owner = @comment.user_id
      xhr :get, :update, :id => @comment, :comment => { :comment => "I'm updated comment", :user_id => stranger_user.id }, :article_id => @comment.commentable.id
      original_owner.should be_eql Comment.find(@comment.id).user_id
    end

    it "should not access to create comment with invalid article_id" do
      stranger_article = Factory :article
      original_news = @comment.commentable_id
      comment = "I'm a new comment"
      xhr :get, :create, :comment => { :comment => comment, :commentable_id => stranger_article.id }, :article_id => @comment.commentable.id
      original_news.should be_eql Comment.find_by_comment(comment).commentable_id
    end
  end

  describe "as signed out user" do
    it "should not render update template on update action by ajax" do
      xhr :get, :update, { :id => @comment, :comment => { :comment => "new text" }, :article_id => @comment.commentable_id }
      response.should_not render_template "comments/update"
    end
  end
end