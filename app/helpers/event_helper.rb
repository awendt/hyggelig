module EventHelper

  def event_title
    if controller.action_name == "new"
      "Create a new event | hyggelig.org"
    else
      @event.name
    end
  end

end
