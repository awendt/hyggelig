class EventController < ApplicationController

  def new
    @event = Event.new(params[:event])

    return unless request.post?
    if @event.save
      redirect_to :action => 'show', :id => @event.permalink
    end
  end

  def show
    @event = Event.find_by_permalink(params[:id])
    if @event
      flash[:notice] = "You can now mail your guests the URL for this page: <a href=\"#{url_for event_url}\">#{url_for event_url}</a>"
    else
      flash[:notice] = "Could not find an event at the location \"#{params[:id]}\""
      redirect_to :action => 'new'
    end
  end


end
