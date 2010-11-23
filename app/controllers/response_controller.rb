class ResponseController < ApplicationController

  layout "application", :except => :feed

  def feed
    @event = Event.find_by_permalink(params[:permalink])
    unless @event
      render :file => "#{Rails.root}/public/404.html", :status => 404
    end
  end

end
