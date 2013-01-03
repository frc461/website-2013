class PermissionsController < ApplicationController
  def create
    @permission = Permission.new(params[:permission])
    @permission.save
  end

  def destroy
  end
end
