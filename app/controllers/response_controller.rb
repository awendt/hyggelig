class ResponseController < ApplicationController

  layout "application", :except => :feed

  def feed
    @event = Event.find_by_permalink(params[:permalink])
    unless @event
      render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
    end
  end

end
