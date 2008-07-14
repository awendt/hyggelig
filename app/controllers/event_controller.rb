class EventController < ApplicationController

  def new
    @event = Event.new(params[:event])

    return unless request.post?
    if @event.save
      flash[:notice] = l(:flash, :give_url, :url => url_for(event_url(@event.permalink)))
      redirect_to event_url(@event.permalink)
    end
  end

end
