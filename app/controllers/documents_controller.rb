class DocumentsController < InheritedResources::Base
	def create 
		@document = Document.new()
		@document.name = params[:document][:name]
		@document.filename = params[:document][:filename]
		@document.secret_code = params[:document][:secret_code]
		if @document.save
			redirect_to documents_path
		else
			render :new
		end
	end
	
end
