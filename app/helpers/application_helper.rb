require 'bluecloth'
module ApplicationHelper
  def super_format(text)
    
  end

  def format(text)
    sanitize(markdown(text))
  end

  def markdown(text)
    photocheck(text)
    linkcheck(text)
    BlueCloth::new(text).to_html
  end

  def photocheck(text)
    gsubber = text.gsub!(/\[[Aa]lbum ([^\[\]]+)\]\[[Pp]hoto (\d+)\](\[([rl])\])?/) do |s|
      if s != ""
        begin
          if $4
            if $4 == "r"
              image_tag(Photo.where("album_id LIKE ? and id LIKE ?",
                                    Album.where("name LIKE ?", $1).first.id, $2.to_i).first.image.url,
                        :class => "pull-right floating-content-img")
            elsif $4 == "l"
              image_tag(Photo.where("album_id LIKE ? and id LIKE ?",
                                    Album.where("name LIKE ?", $1).first.id, $2.to_i).first.image.url,
                        :class => "pull-left floating-content-img")
            end
          else
            image_tag(Photo.where("album_id LIKE ? and id LIKE ?",
                                  Album.where("name LIKE ?", $1).first.id, $2.to_i).first.image.url,
                      :class => "content-img")
          end
        rescue
          "!! NO SUCH PHOTO !!"
        end
      else s
      end
    end
  end

  def linkcheck(text)
    gsubber = text.gsub!(/\[[Pp]age ([^\[\]]+)\](\[([^\[\]]+)\])?/) do |s|
      begin
        if $3
          link_to_page Page.where("title LIKE ?", $1).first, $3
        else
          link_to_page Page.where("title LIKE ?", $1).first
        end
      rescue
        "!! NO SUCH PAGE !!"
      end
    end
  end

  def page_path (page, thing = nil)
    if thing #hacky update fix
      return '/pages/' + page.id.to_s
    else
      titles = [page]
      while titles.first.parent_id
        titles.unshift(Page.find(titles.first.parent_id))
      end
      titles.map! do |t|
        t.title.gsub(/ /,"_")
      end
      '/pages/' + titles.join("/")
    end
  end
  
  def link_to_page (page, text = nil)
    ('<a href="' + page_path(page) + '">' + (text ? text : page.title) + '</a>').html_safe
  end
end
