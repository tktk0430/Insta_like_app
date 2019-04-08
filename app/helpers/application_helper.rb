module ApplicationHelper
  def page_title
    !@page_title.nil? ? "#{@page_title} | Insta App" : "Insta App"
  end

  def logo
    if login?
      link_to 'INSTA_APP', root_path, id:'logo', class:'none'
    else
      link_to 'INSTA_APP', root_path, id:'logo'
    end
  end
end
