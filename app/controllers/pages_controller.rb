class PagesController < InheritedResources::Base
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => :show

  def show
    if params[:title] || params[:id]
      if params[:id] =~ /^\d+(\.\d+)?$/
        @page = Page.find(params[:id])
      else
        params[:id].gsub!(/_/, ' ')
        puts params[:id]
        @page = Page.where("title LIKE ?", params[:id]).first
      end

    end
    redirect_to root_url unless @page
  end
end
