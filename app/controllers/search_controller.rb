class SearchController < ApplicationController
  def search
    queries = params[:search].split(' ')
    @pagethings = []
    @postthings = []
    @eventhings = []
    @albuthings = []
    queries.each do |query|
      @pagethings += Page.tagged_with(query)
      @pagethings += Page.where("lower(title) LIKE lower(?)", "%" + query + "%")
      #@pagethings += Page.where("lower(content) LIKE lower(?)", "%" + query + "%") Don't think this and below content checker really work unless we also filter out keywords like "in" or "and"
      @postthings += Post.tagged_with(query)
      @postthings += Post.where("lower(title) LIKE lower(?)", "%" + query + "%")
      #@postthings += Post.where("lower(content) LIKE lower(?)", "%" + query + "%") Or, we could search for these without seperated queries. I'll add that just in case.
      if current_user
        @eventhings += Event.where("lower(title) LIKE lower(?)", "%" + query + "%")
      else
        @eventhings += Event.where(:public => true).where("lower(title) LIKE lower(?)", "%" + query + "%")
      end
      @albuthings += Album.tagged_with(query)
      @albuthings += Album.where("lower(name) LIKE lower(?)", "%" + query + "%")
    end
    @pagethings += Page.where("lower(content) LIKE lower(?)", "%" + params[:search] + "%")
    @postthings += Post.where("lower(content) LIKE lower(?)", "%" + params[:search] + "%")
    @pagethings.uniq!
    @postthings.uniq!
    @eventhings.uniq!
    @albuthings.uniq!
  end
end
