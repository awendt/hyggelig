class RepliesController < ApplicationController
  # GET /replies
  # GET /replies.xml
  def index
    @replies = Reply.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @replies }
    end
  end

  # GET /replies/1
  # GET /replies/1.xml
  def show
    @reply = Reply.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reply }
    end
  end

  # GET /replies/new
  # GET /replies/new.xml
  def new
    @reply = Reply.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reply }
    end
  end

  # GET /replies/1/edit
  def edit
    @reply = Reply.find(params[:id])
  end

  # POST /replies
  # POST /replies.xml
  def create
    @event = Event.find_by_permalink(params[:permalink])
    @reply = Reply.new(params[:reply])
    @reply.event = @event

    unless @event
      flash[:error] = :'flash.event_not_found'
      flash[:error_item] = "<q>#{params[:permalink]}</q>"
      redirect_to(create_path) and return
    end

    respond_to do |format|
      if @reply.save
        format.html do
          flash[:notice] = 'Reply was successfully created.'
          redirect_to(event_url(@event.permalink))
        end
        format.xml  { render :xml => @reply, :status => :created, :location => @reply }
        format.js   # create.js.erb
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /replies/1
  # PUT /replies/1.xml
  def update
    @reply = Reply.find(params[:id])

    respond_to do |format|
      if @reply.update_attributes(params[:reply])
        flash[:notice] = 'reply was successfully updated.'
        format.html { redirect_to(@reply) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.xml
  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy

    respond_to do |format|
      format.html { redirect_to(replies_url) }
      format.xml  { head :ok }
    end
  end
end
