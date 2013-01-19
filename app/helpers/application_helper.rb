require 'bluecloth'
module ApplicationHelper
  def super_format(text)
    
  end

  def format(text)
    sanitize(photocheck(text))
  end

  def markdown(text)
    BlueCloth::new(text).to_html
  end

  def photocheck(text)
    begin
      gsubber = text.gsub!(/\[[Aa]lbum ([^\[\]]+)\]\[[Pp]hoto (\d+)\](\[([rl])\])?/) { |s|
        if s != ""
          begin
            if $4
              if $4 == "r"
                image_tag(Photo.where("album_id LIKE ? and id LIKE ?",
                                      Album.where("name LIKE ?", $1).first.id, $2.to_i).first.image.url,
                          :class => "pull-right smaller-img")
              elsif $4 == "l"
                image_tag(Photo.where("album_id LIKE ? and id LIKE ?",
                                      Album.where("name LIKE ?", $1).first.id, $2.to_i).first.image.url,
                          :class => "pull-left smaller-img")
              end
            else
              image_tag(Photo.where("album_id LIKE ? and id LIKE ?",
                                    Album.where("name LIKE ?", $1).first.id, $2.to_i).first.image.url)
            end
          rescue
            "!! NO SUCH PHOTO !!"
          end
        else s
        end }
                           # "thing in brackets \\1")
    # rescue
    #   raise "#{$1} - #{$2}"
    end
    markdown text
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
