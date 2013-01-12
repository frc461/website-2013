class PostsController < InheritedResources::Base
  load_and_authorize_resource
  def index
    @posts = Post.order('created_at DESC')
  end
end
