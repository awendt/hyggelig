class ResponseController < ApplicationController

  layout "application", :except => :feed

  def post
    @event = Event.find_by_permalink(params[:id])
    @response = Response.new(params[:response])
    @response.event = @event

    if !@event
      flash[:notice] = l(:flash, :event_not_found, :location => params[:id])
      redirect_to :controller => 'event', :action => 'new'
    end

    return unless request.post?

    unless @response.save
      flash[:notice] = "Your response could not be saved"
    end
  end

  def feed
    @event = Event.find_by_permalink(params[:id])
    @guests = @event.guests_by_reverse_chron
  end

end
