class Ability
	include CanCan::Ability

	def initialize(user)
		logged_in = true if user

		# Guest user for if the current user is not logged in.
		user ||= User.new

		can :create, User

		can :read, Album
		can :read, Event
		can :read, Page
		can :read, Photo
		can :read, Post

		if logged_in
			# Lowercase user `user` is the user initialize is called on,
			# not the class User.
			can :create, Comment

			can :destroy, Comment
			cannot :destroy, Comment, parent_id: nil

			can :manage, Comment, user_id: user.id

			can :read, Comment
			can :read, Event
			can :read, Forum
			can :read, Todo
			can :read, user

			can :update, user

			can :write, Todo

			event_access = false
			forum_access = false
			group_access = false
			page_access = false
			photo_access = false
			post_access = false
			user_access = false

			user.groups.each do |g|
				event_access ||= g.event_access
				forum_access ||= g.forum_access
				group_access ||= g.group_access
				page_access  ||= g.page_access
				photo_access ||= g.photo_access
				post_access  ||= g.post_access
				user_access  ||= g.user_access
			end

			if forum_access
				can :manage, Comment
				can :manage, Forum
				
				cannot :destroy, Comment
				cannot :destroy, Forum
			end

			if group_access
				can :manage, Group
				
				cannot :destroy, Group
			end

			if page_access
				can :manage, Page
				
				cannot :destroy, Page
			end

			if photo_access
				can :manage, Album
				can :manage, Photo
				
				cannot :destroy, Album
				cannot :destroy, Photo
			end

			if post_access
				can :manage, Post
				
				cannot :destroy, Post
			end

			if user_access
				can :manage, User
				
				cannot :destroy, User
			end
		end

		# Admins can do everything.
		can :manage, :all if user.admin
	end
end
