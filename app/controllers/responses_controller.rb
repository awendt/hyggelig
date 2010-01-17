class ResponsesController < ApplicationController
  # GET /responses
  # GET /responses.xml
  def index
    @responses = Response.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @responses }
    end
  end

  # GET /responses/1
  # GET /responses/1.xml
  def show
    @response = Response.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @response }
    end
  end

  # GET /responses/new
  # GET /responses/new.xml
  def new
    @response = Response.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @response }
    end
  end

  # GET /responses/1/edit
  def edit
    @response = Response.find(params[:id])
  end

  # POST /responses
  # POST /responses.xml
  def create
    @event = Event.find_by_permalink(params[:permalink])
    @response = Response.new(params[:response])
    @response.event = @event

    unless @event
      flash[:error] = :'flash.event_not_found'
      flash[:error_item] = "<q>#{params[:permalink]}</q>"
      redirect_to(create_path) and return
    end

    respond_to do |format|
      if @response.save
        flash[:notice] = 'Response was successfully created.'
        format.html { redirect_to(event_url(@event.permalink)) }
        format.xml  { render :xml => @response, :status => :created, :location => @response }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @response.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /responses/1
  # PUT /responses/1.xml
  def update
    @response = Response.find(params[:id])

    respond_to do |format|
      if @response.update_attributes(params[:response])
        flash[:notice] = 'Response was successfully updated.'
        format.html { redirect_to(@response) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @response.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1
  # DELETE /responses/1.xml
  def destroy
    @response = Response.find(params[:id])
    @response.destroy

    respond_to do |format|
      format.html { redirect_to(responses_url) }
      format.xml  { head :ok }
    end
  end
end
