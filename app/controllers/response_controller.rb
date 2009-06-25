class ResponseController < ApplicationController

  layout "application", :except => :feed

  def post
    redirect_to(event_url(params[:permalink])) and return unless request.post?
    @event = Event.find_by_permalink(params[:permalink])
    @response = Response.new(params[:response])
    @response.event = @event

    unless @event
      flash[:error] = :'flash.event_not_found'
      flash[:error_item] = "<q>#{params[:permalink]}</q>"
      redirect_to(create_path) and return
    end

    if @response.save
      flash[:notice] = :'flash.response_saved'
      redirect_to event_url @event.permalink
    else
      render 'event/view' and return
    end
  end

  def feed
    @event = Event.find_by_permalink(params[:permalink])
    unless @event
      render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
    end
  end

end
