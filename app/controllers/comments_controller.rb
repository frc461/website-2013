class CommentsController < InheritedResources::Base
	load_and_authorize_resource

	def index
		if current_user.admin? 
			@comments = Comment.all
		else
			@comments = current_user.comments
		end
	end
	
	def create
		@comment = Comment.new(params[:comment])
		
		if @comment.save && @comment.errors.count == 0
			flash[:notice] = (current_user.admin? ? "Created comment #{@comment.id} successfully!" : "Created comment successfully!")
			
			if @comment.parent_id
				redirect_to @comment.parent
			else
				redirect_to @comment
			end
		else
			flash[:error] = @comment.errors.to_a.join("  ")
			
			if @comment.parent_id
				redirect_to @comment.parent
			else
				render :new
			end

			@comment.destroy
		end
	end

	def update
		@comment = Comment.find(params[:id])

		if @comment.update_attributes(params[:comment]) && @comment.errors.count == 0
			flash[:notice] = (current_user.admin? ? "Edited comment #{@comment.id} successfully!" : "Edited comment successfully!")
			
			if @comment.parent_id
				redirect_to @comment.parent
			else
				redirect_to @comment
			end
		else
			flash[:error] = @comment.errors.to_a.join(", ")
			
			if @comment.parent_id
				redirect_to @comment.parent
			else
				render :edit
			end
		end
	end

	def show
		@comment = Comment.find(params[:id])

		if @comment.parent
			redirect_to @comment.parent
		end
	end

	def destroy
		forum = @comment.forum
		has_comments = @comment.parent ? @comment.parent.comments.count > 0 : false
		parent = @comment.parent

		@comment.comments.each do |comment|
			comment.destroy
		end
		
		@comment.destroy
		
		respond_to do |format|
			format.html { redirect_to (has_comments ? parent : forum) }
			format.json { head :no_content }
		end
	end
end
