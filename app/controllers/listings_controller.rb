class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create]

  # GET /listings
  # GET /listings.json
  def index
    if params[:query].present?
      @listingss = Listing.search params[:query], fields: [:search_tags], where: {imove_in: params[:imove_in], price: {gte: params[:lower], lte: params[:higher]}}, order: {published_at: :desc,}
      @listings = Kaminari.paginate_array(@listingss).page params[:listing]
    else
      @listings = Listing.all.order("published_at DESC").page params[:listing]
    end
    @hash = Gmaps4rails.build_markers(@listings) do |listing, marker|
      marker.lat listing.latitude
      marker.lng listing.longitude
    end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @listing = Listing.find(params[:id])
    @hash = Gmaps4rails.build_markers(@listing) do |listing, marker|
      marker.lat listing.latitude
      marker.lng listing.longitude
    end
    unless @listing.user == current_user
      @listing.view += 1
      @listing.save
    end
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    @listing.published_at = DateTime.now
    respond_to do |format|
      if @listing.save
        @listing.search_tags << @listing.city << @listing.state << @listing.postal_code << @listing.country
        @listing.save
        flash[:notice] = "new listing"
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        flash[:notice] = "update done"
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :js => "window.location='/listings/#{@listing.id}'" }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def autocomplete
    render json: Listing.search(params[:query], autocomplete: true, limit: 10).map(&:city)
  end

  def owner
    @listings = Listing.where(user_id: current_user.id).order("published_at DESC").page params[:page]
    @hash = Gmaps4rails.build_markers(@listings) do |listing, marker|
      marker.lat listing.latitude
      marker.lng listing.longitude
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:name, :desc, :price, :address, :latitude, :longitude, :token, :coin, :published_at, :image, :imove_in, :property, :furnished, :area, :parking, :bathroom, :bedroom)
    end
end
