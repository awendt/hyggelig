class StaticPagesController < ApplicationController

  # cache pages for all actions defined here
  caches_page StaticPagesController.instance_methods - ApplicationController.instance_methods

  PAGES = /tour/

  def show
    render :action => params[:page]
  end

end
