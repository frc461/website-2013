class UsersController < InheritedResources::Base
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
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end
end
