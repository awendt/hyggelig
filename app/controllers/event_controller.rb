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

  def preview_url
    render(:nothing => true) and return unless request.xhr?
    render(:partial => 'url_preview')
  end

  def view
    @event = Event.find_by_permalink(params[:permalink])
    @response = Response.new(params[:response])

    unless @event
      flash[:error] = :'flash.event_not_found'
      flash[:error_item] = "<q>#{params[:permalink]}</q>"
      redirect_to create_path
    end

  end
end
