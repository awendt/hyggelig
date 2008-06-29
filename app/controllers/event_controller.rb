class EventController < ApplicationController

  def new
    @event = Event.new(params[:event])

    return unless request.post?
    if @event.save
      flash[:notice] = "Give this URL to your guests: <a href=\"#{url_for event_url(@event.permalink)}\">#{url_for event_url(@event.permalink)}</a>"
      redirect_to event_url(@event.permalink)
    end
  end

end
