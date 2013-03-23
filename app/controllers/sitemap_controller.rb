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
    @pages = Page.all
    render 'sitemap/robots.txt'
  end
end
