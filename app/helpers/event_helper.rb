module EventHelper

  def event_title
    if controller.action_name == "new"
      l(:slogan)
    else
      @event.name
    end
  end

end
