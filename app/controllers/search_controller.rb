class SearchController < ApplicationController
  def search
    queries = params[:search].split(' ')
    @results = []
    queries.each do |query|
      @results += Page.tagged_with(query)
      @results += Page.where("title LIKE ?", ("%" + query + "%"))
      @results += Post.tagged_with(query)
      @results += Post.where("title LIKE ?", ("%" + query + "%"))
      if current_user
        @results += Event.where("title LIKE ?", ("%" + query + "%"))
      else
        @results += Event.where(:public => true).where("title LIKE ?", ("%" + query + "%"))
      end
      @results += Album.tagged_with(query)
      @results += Album.where("name LIKE ?", ("%" + query + "%"))
    end
    @results.uniq!
  end
end
