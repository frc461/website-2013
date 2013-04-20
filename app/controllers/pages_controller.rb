class PagesController < InheritedResources::Base
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => :show

  def selectpage(id, titles)
   begin
    if id
      if id =~ /^\d+$/
        return Page.find(id)
      else
        testpage = Page.where("title LIKE ?", id.gsub(/_/, ' ').gsub(/~/, ':')).first
        if testpage && !testpage.parent_id
          return testpage
        end
      end
    elsif titles.is_a? String
      if titles =~ /^\d+$/
        return Page.find(titles)
      else
        titles = titles.split("/")
        titles.map! do |t|
          Page.where("title LIKE ?", t.gsub(/_/, ' ').gsub(/~/, ':')).first
        end
        titles.each do |p|
          if titles.first.id == p.id
            if p.parent_id
              raise "misformed url, base haz a parent"
            end
          end
          if p.id != titles.last.id
            if titles[(titles.index(p) + 1)].parent_id != p.id
              raise "nope, page is " + p.title + " w/ index " + titles.index(p).to_s + " & parid " + p.parent_id.to_s
            end
          end
        end
        return Page.find(titles.last.id)
      end
    end
   rescue Exception => ex
     # redirect_to error_path
     render "error/index", :status => 404
   end
    # if params[:title] || params[:id]
    #   if params[:id] =~ /^\d+(\.\d+)?$/
    #     @page = Page.find(params[:id])
    #   elsif params[:parents]
    #     params[:parents] = [params[:parents]] if params[:parents].is_a? String
    #     params[:parents].each do |parent|
    #       if parent.id == params[:parents].last.id
    #         if parent.id != Page.where("title LIKE ?", params[:title]).first.parent_id
    #           raise "Some string"
    #         end
    #       elsif params[:parents].((params[:parents].index(parent)) + 1).id != parent.parent_id
    #         raise "some string2"
    #       end
    #       params[:title].gsub!(/_/, ' ')
    #       puts params[:title]
    #       @page = Page.where("title LIKE ?", params[:title]).first
    #     end
    #   else
    #     params[:id].gsub!(/_/, ' ')
    #     puts params[:id]
    #     @page = Page.where("title LIKE ?", params[:id]).first
    #   end
    # end
    # redirect_to root_url unless @page
  end

  # for some reason this doesn't work
  # def delete
  #   @page = selectpage(params[:id], params[:titles])
  #   @page.destroy
  # end

  def show
    @page = selectpage(params[:id], params[:titles])
    # redirect_to error_path unless @page
    render "error/index", :status => 404 unless @page
  end

  def destroy
    @page = Page.find(params[:id])
    @page.delete

    redirect_to pages_path, :notice => "Removed page."
  end

  def index
    redirect_to sitemap_path, :status => 302
  end
end
