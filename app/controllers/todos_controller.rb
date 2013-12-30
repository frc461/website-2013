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

	def assign
		@todo = Todo.find(params[:id])
		
		@todo.users << User.where(:name => params[:name]).first

		redirect_to @todo, :notice => "Successfully assigned #{params[:name]}!"
	end

	def unassign
		@todo = Todo.find(params[:id])
		
		@todo.users.delete(User.where(:name => params[:commit]).first)

		redirect_to @todo, :notice => "Successfully un-assigned #{params[:commit]}!"
	end
end
