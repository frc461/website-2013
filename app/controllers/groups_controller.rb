class GroupsController < InheritedResources::Base
	load_and_authorize_resource
	
	def show
		@group = Group.find(params[:id])
	end

	def join
		@group = Group.find(params[:id])

		@group.users << current_user

		redirect_to @group, notice: "Successfully joined #{@group.name}!"
	end

	def unjoin
		@group = Group.find(params[:id])

		@group.users.delete(current_user)

		redirect_to @group, notice: "Successfully left #{@group.name}!"
	end
end
