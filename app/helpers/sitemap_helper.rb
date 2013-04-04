module SitemapHelper

  def page_ul page
    thing = "<ul>"
    page.pages.each do |child|
      thing += "<li>"
      thing += link_to_page child
      thing += "</li>"
      thing += page_ul(child) if child.pages.count > 0
    end
    thing += "</ul>"
    return thing.html_safe
  end
end
