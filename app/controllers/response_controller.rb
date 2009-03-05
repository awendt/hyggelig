class ResponseController < ApplicationController

  layout "application", :except => :feed

  def post
    @event = Event.find_by_permalink(params[:id])
    @response = Response.new(params[:response])
    @response.event = @event

    if @event
      @guests = @event.guests_by_reverse_chron
    else
      flash[:error] = :'flash.event_not_found'
      flash[:error_item] = "<q>#{params[:id]}</q>"
      redirect_to :controller => 'event', :action => 'new'
    end

    return unless request.post?

    if @response.save
      flash[:notice] = :'flash.response_saved'
    end
  end

  def feed
    @event = Event.find_by_permalink(params[:id])
    if @event
      @guests = @event.guests_by_reverse_chron
    else
      render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
    end
  end

end
