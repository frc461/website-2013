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

  def link_to_page (page, text = nil)
    if text == nil
      ('<a href="/pages/' + page.title.gsub(/ /, '_') + '">' + page.title + '</a>').html_safe
    else
      ('<a href="/pages/' + page.title.gsub(/ /, '_') + '">' + text + '</a>').html_safe
    end
  end
end
