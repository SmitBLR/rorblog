# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    comment "I'm a comment"

    after_build do |comment|
      comment.commentable = Factory(:article)
      comment.commentable_type = "Article"
      comment.user = Factory(:user)
    end
  end
end
