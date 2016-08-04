class Listing < ActiveRecord::Base
	belongs_to :user
	has_many :favorite_listings
	searchkick autocomplete: ['city']
	# attr_accessible :address, :latitude, :longitude
	geocoded_by :address
	has_attached_file :image
	validates_attachment :image,
                     content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
	reverse_geocoded_by :latitude, :longitude do |obj,results|
	  if geo = results.first
	  	obj.state 	=geo.state
	    obj.city    = geo.city
	    obj.postal_code = geo.postal_code
	    obj.country = geo.country
	  end
	end

	after_validation :reverse_geocode, :geocode, :if => :address_changed?

	
	enum type: { landed: 1, high_rise: 2, other: 3 }
	enum furnish_type: { fully: 1, partialy: 2, basic: 3 }
end
