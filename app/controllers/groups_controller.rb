class GroupsController < InheritedResources::Base
  def add_permission
  end

  def show
    @group = Group.find(params[:id])
    @permission = Permission.new
    @permissions = @group.permissions
  end
end
