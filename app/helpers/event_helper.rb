module EventHelper

  def event_title
    if controller.action_name == "new"
      "#{SITE_NAME} | #{l(:slogan)}"
    else
      "#{@event.name}, #{@event.date} | #{SITE_NAME}"
    end
  end

end
