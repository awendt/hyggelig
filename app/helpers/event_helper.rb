module EventHelper

  def event_title
    if controller.action_name == "new"
      "#{l(:site_name)} | #{l(:slogan)}"
    else
      "#{@event.name}, #{@event.date} | #{l(:site_name)}"
    end
  end

end
