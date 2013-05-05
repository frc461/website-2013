class TodosController < InheritedResources::Base
	def create
		@todo = Todo.create(params[:todo])
		if @todo.save
			redirect_to todos_path, :notice => "Successfully created todo."
		else
			render :new
		end
	end
end
