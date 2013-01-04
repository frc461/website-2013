class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin
      can :manage, :all
    end
#can do |action, subject_class, subject|
#     user.permissions.find_all_by_action(aliases_for_action(action)).any? do |perm|
#       perm.subject_class == subject_class.to_s && (subject.nil? || perm.subject_id.nil? || perm.subject_id == subject.id)
#     end
#  end
  end
end
