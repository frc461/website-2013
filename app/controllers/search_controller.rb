class SearchController < ApplicationController

  def search
    if params[:search]
      queries = params[:search].split(' ')
      if queries.count < 1
        render 'search/none'
      else
        @pagethings = []
        @postthings = []
        @eventhings = []
        @albuthings = []
        queries.each do |query|
          # TODO: FIX SUBSTRING MATCHING (eg "hi" matching "this")
          # Also: make sure we aren't matching something that will be parsed out
          # Lastly: make sure all are navigable
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
        @pagethings.delete("")
        @postthings.delete("")
        @eventhings.delete("")
        @albuthings.delete("")
        # render 'search/search'
      end
    else
      render 'search/none'
    end
  end
end
