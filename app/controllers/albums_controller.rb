class AlbumsController < InheritedResources::Base
	load_and_authorize_resource

	def index
		if current_user && current_user.admin
			@albums = Album.all
		else
			@albums = Album.where(visible: true)
		end
	end
end
