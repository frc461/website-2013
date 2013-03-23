class SitemapController < ApplicationController
  def index 
    @posts = Post.all
    @pages = Page.all
    @albums = Album.all
    @events = Event.all
    respond_to do |format|
      format.xml { } # sitemap is a named scope
      format.html{ }
    end
  end

  def robots
    # respond_to :txt
    @pages = Page.all
    render 'sitemap/robots.txt.erb'
    # respond_to do |format|
    #   format.txt{
    #     render 'sitemap/robots.txt'
    #     respond_with @pages}
    # end
  end
end
