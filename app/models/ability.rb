class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin
      can :manage, :all
    end
      can do |action, subject_class, subject|
        user.all_permissions.delete_if do |perm|
          case action
            when "read"
              !perm.read
            when "write"
              !perm.write
            when "delete"
              !perm.remove
            when "update"
              !perm.write && !perm.remove
            when "manage"
              !perm.write && !perm.read && !perm.remove && !perm.update
            when "execute"
              !perm.execute
            end
        end.any? do |perm|
        perm.securable_type == subject_class.to_s && (subject.nil? || perm.securable_id.nil? || perm.securable_id == subject.id)
      end
    end
    can :read, Page
    can :read, Post
    can :read, Album
    can :read, Photo
    can :create, User
  end
end
