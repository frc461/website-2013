class GroupsController < InheritedResources::Base
	load_and_authorize_resource
	
	def show
		@group = Group.find(params[:id])
	end
end
