class SearchController < ApplicationController
  def search
    queries = params[:search].split(' ')
    @results = []
    queries.each do |query|
      @results += Page.tagged_with(query)
      @results += Page.where("lower(title) LIKE lower(?)", "%" + query + "%")
      @results += Post.tagged_with(query)
      @results += Post.where("lower(title) LIKE lower(?)", "%" + query + "%")
      if current_user
        @results += Event.where("lower(title) LIKE lower(?)", "%" + query + "%")
      else
        @results += Event.where(:public => true).where("lower(title) LIKE lower(?)", "%" + query + "%")
      end
      @results += Album.tagged_with(query)
      @results += Album.where("lower(name) LIKE lower(?)", "%" + query + "%")
    end
    @results.uniq!
  end
end
