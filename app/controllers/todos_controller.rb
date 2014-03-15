class TodosController < InheritedResources::Base
	def create
		@todo = Todo.create(params[:todo])
		
		if @todo.save
			redirect_to todos_path, notice: "Successfully created todo."
		else
			render :new
		end
	end

	def complete
		@todo = Todo.find(params[:id])

		@todo.done = true

		@todo.save

		redirect_to todos_path, notice: "To Do item completed!"
	end

	def uncomplete
		@todo = Todo.find(params[:id])

		@todo.done = false

		@todo.save

		redirect_to todos_path, notice: "To Do item un-completed!"
	end

	def assign
		@todo = Todo.find(params[:id])

		if User.where(name: params[:name]).count == 0
			redirect_to @todo, alert: "#{params[:name]} does not exist!"

			return
		end

		user_to_add = User.where(name: params[:name]).first

		if !@todo.users.include? user_to_add
			@todo.users << User.where(name: params[:name]).first

			redirect_to @todo, notice: "Successfully assigned #{who(params[:name])}!"
		else
			redirect_to @todo, alert: "#{who(params[:name], false).capitalize} already assigned!"
		end
	end

	def unassign
		@todo = Todo.find(params[id])
		
		@todo.users.delete(User.where(:name: params[:commit]).first)

		redirect_to @todo, notice: "Successfully un-assigned #{who(params[:commit])}!"
	end

	private
	# Compares current_user.name and name
	def who(name, yourself = true)
		if yourself
			current_user.name == name ? "yourself" : name
		else
			current_user.name == name ? "you are" : "#{name} is"
		end
	end
end
