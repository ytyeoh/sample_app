class UsersController < ApplicationController
  def create
    byebug
    listing = Listing.find(params[:listing_id])
    FavoriteListing.create(user_id: current_user.id, listing_id: params[:listing_id])
  end
  def destroy
byebug
  end
end