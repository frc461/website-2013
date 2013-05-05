class PermissionsController < ApplicationController
	load_and_authorize_resource
	
	def create
		@permission = Permission.new(params[:permission])
		if @permission.save && @permission.errors.count == 0
			flash[:notice] = "Made teh permission"
		else
			flash[:error] = @permission.errors.to_a.join(", ")
		end
		#raise "nope.avi"
		redirect_to @permission.principal.authenticatable
	end

	def destroy
	end
end
