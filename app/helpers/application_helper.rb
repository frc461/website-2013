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
    doccheck(text)
    BlueCloth::new(text).to_html
  end

  def markback(text)
    return format(text).gsub(/<[^<>]+>/, '')
  end
  
  def photocheck(text)
    gsubber = text.gsub!(/\[[Aa]lbum ([^\[\]]+)\]\[[Pp]hoto (\d+)\](\[([rl])\])?/) do |s|
      if s != ""
        begin
          if $4
            if $4 == "r"
              image_tag(Photo.where("album_id = ? and id = ?",
                                    Album.where("name LIKE ?", $1).first.id, $2.to_i).first.image.url,
                        :class => "pull-right floating-content-img")
            elsif $4 == "l"
              image_tag(Photo.where("album_id = ? and id = ?",
                                    Album.where("name LIKE ?", $1).first.id, $2.to_i).first.image.url,
                        :class => "pull-left floating-content-img")
            end
          else
            image_tag(Photo.where("album_id = ? and id = ?",
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
        "Error: !! NO SUCH PAGE !!"
      end
    end
  end

  def doccheck(text)
    gsubber = text.gsub!(/\[[Dd]oc(ument)? ([^\[\]]+)\](\[([^\[\]]+)\])?/) do |s|
      if s != ""
        begin
          doc = Document.where("name LIKE ?", $2).first
          if $4
            link_to $4, doc.filename
          else
            link_to doc.name, doc.filename
          end
        rescue
          "!! NO SUCH DOCUMENT !!"
        end
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
        t.title.gsub(/ /,"_").gsub(/:/, "~")
      end
      '/pages/' + titles.join("/")
    end
  end
  
  def link_to_page (page, text = nil, html = "")
    ('<a href="' + page_path(page) + '" ' + html +'>' + (text ? text : page.title) + '</a>').html_safe
  end

  def format_tweet (tweet)
    text = tweet.text
    tweet.urls.each do |url|
      text.gsub!(url.url, "<a href=\"" + url.expanded_url + "\">" + url.display_url + "</a>")
    end
    tweet.media.each do |media|
      text.gsub!(media.url, "<a href=\"" + media.expanded_url + "\">" + media.display_url + "</a>")
    end
    tweet.hashtags.each do |hashtag|
      text.gsub!("#" + hashtag.text, "<a href=\"https://twitter.com/search/?q=%23" + hashtag.text + "\" target=\"_blank\">" + "#" + hashtag.text + "</a>")
    end
    text
  end

#  def uri?(string)
#    if string.match(/^https?:\/\//)
#      true
#    else
#      false
#    end
#  end
end
