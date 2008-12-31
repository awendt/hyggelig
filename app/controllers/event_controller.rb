class EventController < ApplicationController

  def new
    @event = Event.new(params[:event])

    return unless request.post?
    if @event.save
      # put in a linebreak
      flash[:notice] = :'flash.give_url'
      # build a URL for current event (redirect below prevents using url_for)
      url = url_for(event_url(@event.permalink))
      # use that URL to link to the current page
      flash[:notice_item] = ["#{url}", "#{url}"]
      redirect_to event_url(@event.permalink)
    end
  end

end
