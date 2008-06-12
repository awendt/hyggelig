class EventController < ApplicationController

  def new
    @event = Event.new(params[:event])

    return unless request.post?
    if @event.save
      redirect_to :action => 'show', :id => @event
    end
  end

end
