class UsersController < InheritedResources::Base
  load_and_authorize_resource

  def new
    @user = User.new
    @permission = Permission.new
  end

  def add_permission
  end

  def show
    @user = User.find(params[:id])
    @permission = Permission.new
    @permissions = @user.permissions
  end

  def create
    @user = User.new(params[:user])
    @user.group_ids = params[:group_ids]
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end
end
