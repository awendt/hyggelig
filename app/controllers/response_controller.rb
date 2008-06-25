class ResponseController < ApplicationController

  def post
    return unless request.post?

    @rsvp = Response.new(params[:response])
    @rsvp.event = Event.find_by_permalink(params[:id])

    if @rsvp.save
      redirect_to :controller => 'event', :action => 'show', :id => @rsvp.event.permalink
    end
  end

end
