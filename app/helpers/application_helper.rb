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
end
