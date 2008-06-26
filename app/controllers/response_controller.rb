class ResponseController < ApplicationController

  def post
    @event = Event.find_by_permalink(params[:id])
    @response = Response.new(params[:response])
    @response.event = @event

    if !@event
      flash[:notice] = "Could not find an event at the location \"#{params[:id]}\""
      redirect_to :controller => 'event', :action => 'new'
    end

    return unless request.post?

    if @response.save
      flash[:notice] = "Your response could not be saved"
    end
  end

end
