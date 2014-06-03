class UsersController < InheritedResources::Base
	load_and_authorize_resource

	def new
		@user = User.new

		if current_user && current_user.admin
			@groups = Group.all
		else
			@groups = Group.where(joinable: true)
		end

		if current_user
			@groups += current_user.groups
			
			@groups.uniq!
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def create
		params[:user].delete(:admin) unless can? :manage, User
		
		if !(current_user && current_user.admin) && params[:user][:group_ids]
			params[:user][:group_ids].delete_if do |gid|
				!Group.find(gid).joinable
			end
		end
		
		@user = User.new(params[:user])

		if (group = Group.where(name: "Everybody")).count > 0
			group.first.users << @user
		end
		
		if @user.save
			if !(current_user && current_user.admin)
				redirect_to root_url, notice: "Signed up!"
			else
				redirect_to root_url, notice: "New user created!"
			end
			
			session[:user_id] = @user.id if !(current_user && current_user.admin)
		else
			if current_user && current_user.admin
				@groups = Group.all
			else
				@groups = Group.where(joinable: true)
			end

			if current_user
				@groups += current_user.groups
				@groups.uniq!
			end
			render "new"
		end
	end

	def edit
		@user = User.find(params[:id])

		if current_user && current_user.admin
			@groups = Group.all
		else
			@groups = Group.where(joinable: true)
		end
		
		if current_user
			@groups += current_user.groups
			@groups.uniq!
		end
	end

	def update
		params[:user].delete(:admin) unless can? :manage, User
		
		if !(current_user && current_user.admin) && params[:user][:group_ids]
			params[:user][:group_ids].delete_if do |gid|
				!(Group.find(gid).joinable || (current_user && Membership.where(user_id: current_user.id, group_id: gid).count > 0))
			end
		end
		
		@user = User.find(params[:id])
		
		if @user.update_attributes(params[:user])
			redirect_to @user
		else
			if current_user && current_user.admin
				@groups = Group.all
			else
				@groups = Group.where(joinable: true)
			end

			if current_user
				@groups += current_user.groups
				@groups.uniq!
			end
			render "edit"
		end
	end

	def destroy
		# Log out before deleting.
		session[:user_id] = nil

		@user.destroy

		redirect_to root_url
	end
end
