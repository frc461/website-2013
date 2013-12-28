class TodosController < InheritedResources::Base
	def create
		@todo = Todo.create(params[:todo])
		
		if @todo.save
			redirect_to todos_path, :notice => "Successfully created todo."
		else
			render :new
		end
	end

	def complete
		@todo = Todo.find(params[:id])

		@todo.done = true

		@todo.save

		redirect_to todos_path, :notice => "To Do item completed!"
	end

	def uncomplete
		@todo = Todo.find(params[:id])

		@todo.done = false

		@todo.save

		redirect_to todos_path, :notice => "To Do item un-completed!"
	end
end
