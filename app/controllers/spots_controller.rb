class SpotsController < ApplicationController
  before_action :set_spot, only: %i[ show edit update destroy ] 
  before_action :authenticate_user! 

  respond_to :js, :html, :json
  
  #Favorite
  def toggle_favorite
    @spot = Spot.find_by(id: params[:id])
    current_user.favorited?(@spot) ? current_user.unfavorite(@spot) : current_user.favorite(@spot)
  end

  #Search
  def search
    if params[:search].blank?
      redirect_to(root_path, alert: "Empty field!") and return  
    else
    
      @parameter = params[:search]
      @results = Spot.where(['name LIKE ?', "%#{params[:search]}%"])
      @users = User.where(['name like?', "%#{params[:search]}%"])
    end
  end

  #Like/Dislike
  def like
    @spot = Spot.find(params[:id])
    if params[:format]=='like'
      @spot.liked_by current_user
    elsif params[:format]=='dislike'
      
      @spot.downvote_from current_user
    end
    redirect_to spots_path
  end

  
  
  #Favorites
  def filter
    @favorite_spots = current_user.favorited_by_type('Spot')
  end

  #MySpots
  def myspots
    @spots = current_user.spots
    
  end

  #User page
  def user_page
    @user = User.find(params[:id])
    
  end


  

  # GET /spots or /spots.json + Sort
  def index
    if params[:sort] == "alphabetical"
      @spots=Spot.all.order(:name)

    elsif params[:sort] == "newest"
      @spots=Spot.all.order(:created_at).reverse()

    elsif params[:sort] == "oldest"
      @spots=Spot.all.order(:created_at)
  

    else
  
      @spots = Spot.all
      @favorite_spots = current_user.favorited_by_type('Spot')
    end
    

    
    
  end

  # GET /spots/1 or /spots/1.json
  def show
  end

  # GET /spots/new
  def new
    if not user_signed_in?
      redirect_to spots_path, flash: {notice: "Login to create spot"}
    end
    @spot = Spot.new
   
  end

  # GET /spots/1/edit
  def edit
    if not user_signed_in?
      redirect_to spots_path, flash: {notice: "Login to edit spot"}
    
    elsif current_user.id != @spot.user_id &&  current_user.admin==nil
      redirect_to spots_path, flash: {notice: "You can't edit other's spot"}

  
    end
    
  end

  # POST /spots or /spots.json
  def create

    @spot = Spot.new(spot_params.merge(user_id: current_user.id))
    authorize! :create, @spot, :message => 'BEWARE: you are not authorized to create spots'

    respond_to do |format|
      if @spot.save
        format.html { redirect_to @spot, notice: "Spot was successfully created." }
        format.json { render :show, status: :created, location: @spot }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spots/1 or /spots/1.json
  def update
    respond_to do |format|
      if @spot.update(spot_params)
        format.html { redirect_to @spot, notice: "Spot was successfully updated." }
        format.json { render :show, status: :ok, location: @spot }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
      end
  end

  # DELETE /spots/1 or /spots/1.json
  def destroy
    @spot.destroy
    
    respond_to do |format|
      format.html { redirect_to spots_url, notice: "Spot was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spot
      @spot = Spot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def spot_params
      params.require(:spot).permit(:name , :location ,:likes, :dislikes, :description , :image , :user_id)
    end
end
