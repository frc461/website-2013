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
      @pagethings += Page.where("lower(content) LIKE lower(?)", "%" + query + "%")
      @postthings += Post.tagged_with(query)
      @postthings += Post.where("lower(title) LIKE lower(?)", "%" + query + "%")
      @postthings += Post.where("lower(content) LIKE lower(?)", "%" + query + "%")
      if current_user
        @eventhings += Event.where("lower(title) LIKE lower(?)", "%" + query + "%")
      else
        @eventhings += Event.where(:public => true).where("lower(title) LIKE lower(?)", "%" + query + "%")
      end
      @albuthings += Album.tagged_with(query)
      @albuthings += Album.where("lower(name) LIKE lower(?)", "%" + query + "%")
    end
    @pagethings.uniq!
    @postthings.uniq!
    @eventhings.uniq!
    @albuthings.uniq!
  end
end
