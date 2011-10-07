class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.admin?
        can :manage, :all
      else
        can :create, Comment
      end
    end
    can :read, :all
  end
end
