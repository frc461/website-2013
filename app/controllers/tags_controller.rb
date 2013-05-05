class TagsController < ApplicationController
	def show
		@posts = Post.tagged_with(params[:tag])
		@pages = Page.tagged_with(params[:tag])
		@albums = Album.tagged_with(params[:tag])
		@photos = Photo.tagged_with(params[:tag])
		@forums = Forum.tagged_with(params[:tag])
		@comments = Comment.tagged_with(params[:tag])
	end
end
