class CommentsController < InheritedResources::Base
  load_and_authorize_resource

  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      if @comment.parent_id
        redirect_to @comment.parent
      else
        redirect_to @comment
      end
    else
      if @comment.parent_id
        render @comment.parent, :notice => "You screwed something up there. Check again."
      else
        render :new, :notice => "You screwed something up there. Check again."
      end
    end
  end
end
