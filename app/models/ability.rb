class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here
    user ||= User.new # guest user (not logged in)

    if user.persisted?
      # Project permissions
      can :read, Project # Anyone can read projects
      can :create, Project # Logged in users can create projects
      can :update, Project, user_id: user.id # Users can update their own projects
      can :destroy, Project, user_id: user.id # Users can delete their own projects
      can :update_status, Project, user_id: user.id # Only project owner can update status

      # Comment permissions
      can :read, Comment # Anyone can read comments
      can :create, Comment # Logged in users can create comments
      can :destroy, Comment, user_id: user.id # Users can delete their own comments
    else
      # Guest user permissions
      can :read, Project # Guests can read projects
      can :read, Comment # Guests can read comments
    end
  end
end 