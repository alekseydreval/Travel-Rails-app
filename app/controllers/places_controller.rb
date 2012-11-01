class PlacesController < ApplicationController

 before_filter :redirect_to_login,    only: ['edit', 'update', 'destroy', 'new', 'create']
 before_filter(only: ['edit', 'update', 'destroy']) {|c| c.check_user_identity(Place)}  


  before_filter lambda { 
   session[:fake_place_id] ||= Place.create({name: "foo", description: "barfghfghgjgfhjgj", temp: true}).id 
   @fake_place_id = session[:fake_place_id]; 
          Rails.logger.info(@fake_place_id)
 }, :only => :create

 before_filter lambda { @fake_place_id = session[:fake_place_id] = nil }, :except => :create ##TODO destroy model

  # GET /places
  # GET /places.json
  def index
    @places = Place.where(temp: false)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @places }
    end
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @place = Place.find(params[:id])
    # @pictures = @plcae.pictures
    # @comments = @plcae.comments

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
    end
  end

  # GET /places/new
  # GET /places/new.json
  def new
    @place = Place.new
    @place.ex_links.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @place }
    end
  end

  # GET /places/1/edit
  def edit
      @place = Place.find(params[:id])
      @ex_links = @place.ex_links
      @pictures = @place.pictures
  end

  # POST /places
  # POST /places.json
  def create
   
      respond_to do |format|
        format.json do
          @pic = Place.find(@fake_place_id).pictures.create(pic: params[:place][:picture]) if params[:place][:picture]
          current_user.pictures << @pic 
          render json: @pic.to_json 
        end
        format.html do
          @place = current_user.places.build(params[:place].except(:picture))
          if @place.save
            Place.find(@fake_place_id).pictures.each { |pic| @place.pictures << pic }
            redirect_to action: "index", notice: 'Place was successfully created.'
          else
            flash.now[:alert] = @place.errors.full_messages.to_sentence words_connector: "\n" 
            render action: "new"
          end
        end
     end
  end

  # PUT /places/1
  # PUT /places/1.json
  def update

    @place = Place.find(params[:id])

    respond_to do |format|
        format.html do
          upd = @place.update_attributes(params[:place].except(:picture))
          if upd
            redirect_to places_path, notice: 'Place was successfully updated.'
          else
            flash[:alert] = @place.errors.full_messages #.to_sentence words_connector: "\n" 
            render action: "edit"
          end
        end
        format.json do
          pic = @place.pictures.create(pic: params[:place][:picture]) if params[:place][:picture]
          render json: pic.to_json 
        end
      end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place = Place.find(params[:id])
    @place.destroy

    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end
  end
end

