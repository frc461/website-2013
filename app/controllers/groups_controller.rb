class GroupsController < InheritedResources::Base
  load_and_authorize_resource
  
  def add_permission
  end

  def show
    @group = Group.find(params[:id])
    @permission = Permission.new
    @permissions = @group.permissions
  end
end
