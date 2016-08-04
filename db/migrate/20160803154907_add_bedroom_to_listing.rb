class AddBedroomToListing < ActiveRecord::Migration
  def change
    add_column :listings, :bedroom, :integer
    add_column :listings, :bathroom, :integer
    add_column :listings, :parking, :integer
    add_column :listings, :furnish_type, :integer
    add_column :listings, :area, :integer
    add_column :listings, :type, :integer
  end
end
