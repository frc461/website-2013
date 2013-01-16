class PagesController < InheritedResources::Base
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => :show

  def show
    if params[:id]
      if params[:id] =~ /^\d+$/
        @page = Page.find(params[:id])
      else
        @page = Page.where("title LIKE ?", params[:id].gsub(/_/, ' ')).first
      end
    elsif params[:titles].is_a? String
      if params[:titles] =~ /^\d+$/
        @page = Page.find(params[:titles])
      else
        params[:titles] = params[:titles].split("/")
        params[:titles].map! do |t|
          Page.where("title LIKE ?", t.gsub(/_/, ' ')).first
        end
        params[:titles].each do |p|
          if p.id != params[:titles].last.id
            if params[:titles][(params[:titles].index(p) + 1)].parent_id != p.id
              raise "nope, page is " + p.title + " w/ index " + params[:titles].index(p).to_s + " & parid " + p.parent_id.to_s
            end
          end
        end
        @page = Page.find(params[:titles].last.id)
      end
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
end
