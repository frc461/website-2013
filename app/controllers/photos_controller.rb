class PhotosController < InheritedResources::Base
	load_and_authorize_resource

	def create
		@photo = Photo.new(params[:photo])
		
		respond_to do |format|
			if @photo.save
				format.html {
					redirect_to photos_path
				}
				format.json { render json: [@photo.to_jq_upload].to_json, status: :created, location: @photo }
			else
				format.html { render action: "new" }
				format.json { render json: @photo.errors, status: :unprocessable_entity }
			end
		end
	end
end
