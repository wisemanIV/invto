class Ability
  include CanCan::Ability
 
  def initialize(user)
    # Define abilities for the passed in user here.
    user ||= User.new # guest user (not logged in)
    # a signed-in user can do everything
    if user.role == "admin"
     # an admin can do everything
      can :manage, :all
    elsif user.role == 'default'
      # an editor can do everything to documents and reports
      can :read, [Shareable, Email, Recipient, Message, Click, EmailTemplate, SmsResponse, SmsArchive]
    # but can only read, create and update charts (ie they cannot
      # be destroyed or have any other actions from the charts_controller.rb
      # executed)
       # an editor can only view the annual report
    elsif user.role == 'general'
      # an editor can do everything to documents and reports
      can :read, [Shareable, Email, Recipient, Message, Click, EmailTemplate, SmsResponse, SmsArchive]
      # but can only read, create and update charts (ie they cannot
      # be destroyed or have any other actions from the charts_controller.rb
      # executed)
      can [:read, :create, :update], Message
     # an editor can only view the annual report
    elsif user.role == 'guest'
    end
  end
end