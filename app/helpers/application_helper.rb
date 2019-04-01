module ApplicationHelper
  def page_title
    !@page_title.nil? ? "#{@page_title} | Insta App" : "Insta App"
  end
end
