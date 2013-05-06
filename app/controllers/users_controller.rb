class UsersController < InheritedResources::Base
  load_and_authorize_resource

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    params[:user].delete(:admin) unless session[:user_id] && User.find(session[:user_id]).admin
    if !(session[:user_id] && User.find(session[:user_id]).admin) && params[:user][:group_ids]
      params[:user][:group_ids].delete_if do |gid|
        !Group.find(gid).joinable
      end
    end
    @user = User.new(params[:user])
    # @user.group_ids = params[:group_ids]
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def update
    params[:user].delete(:admin) unless session[:user_id] && User.find(session[:user_id]).admin
    if !(session[:user_id] && User.find(session[:user_id]).admin) && params[:user][:group_ids]
      params[:user][:group_ids].delete_if do |gid|
        !Group.find(gid).joinable
      end
    end
    @user = User.find(params[:id])
    # @user.group_ids = params[:group_ids]
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render "edit"
    end
  end
end
