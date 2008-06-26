class EventController < ApplicationController

  def new
    @event = Event.new(params[:event])

    return unless request.post?
    if @event.save
      flash[:notice] = "Give this URL to your guests: <a href=\"#{url_for event_url}\">#{url_for event_url}</a>"
      redirect_to :controller => 'response', :action => 'post', :id => @event.permalink
    end
  end

end
