class EventsController < ApplicationController
  before_filter :prevent_modifications, :only => [:index, :edit, :update, :destroy]

  # GET /events
  # GET /events.xml
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find_by_permalink(params[:permalink])
    @reply = Reply.new(params[:reply])

    unless @event
      flash[:error] = :'flash.event_not_found'
      flash[:error_item] = "<q>#{params[:permalink]}</q>"
      redirect_to root_path and return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
      format.rss  { render :action => 'feed.rxml' }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        # put in a linebreak
        flash[:notice] = :'flash.give_url'
        # build a URL for current event (redirect below prevents using url_for)
        url = permalink_url(@event.permalink)
        # use that URL to link to the current page
        flash[:notice_item] = [url, url]

        format.html { redirect_to(permalink_path(@event.permalink)) }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash[:notice] = 'Event was successfully updated.'
        format.html { redirect_to(permalink_path(@event)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end

  def preview_url
    render(:nothing => true) and return unless request.xhr?
    render(:partial => 'url_preview')
  end

end
