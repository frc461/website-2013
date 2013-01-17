require 'bluecloth'
module ApplicationHelper
  def super_format(text)
    
  end

  def format(text)
    sanitize(markdown(text))
  end

  def markdown(text)
    BlueCloth::new(text).to_html
  end

  def page_path (page, thing = nil)
    # puts (thing.map {|key, value| "#{key} is #{value}" }).join("\n")
    titles = [page]
    while titles.first.parent_id
      titles.unshift(Page.find(titles.first.parent_id))
    end
    titles.map! do |t|
      t.title.gsub(/ /,"_")
    end
    '/pages/' + titles.join("/")
  end
  
  def link_to_page (page, text = nil)
    ('<a href="' + page_path(page) + '">' + (text ? text : page.title) + '</a>').html_safe
  end
end
