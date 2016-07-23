class FavoriteListingsController < ApplicationController
  def create
    @listing = Listing.find(params[:listing_id])
    if FavoriteListing.create(user_id: current_user.id, listing_id: params[:listing_id])
      redirect_to listing_path(@listing), notice: 'You successfully favourite.' 
      
    else
     return json_error(status: 422, errors: 'unable to unlike')
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @favorite = current_user.favorite_listings.find_by(listing_id: params[:id])
    if @favorite.destroy
      redirect_to listing_path(@listing), notice: 'You just unfavourite' 
      
    else
     return json_error(status: 422, errors: 'unable to unlike')
    end
  end
end