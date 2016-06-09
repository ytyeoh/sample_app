class Listing < ActiveRecord::Base
	belongs_to :user
	# attr_accessible :address, :latitude, :longitude
	geocoded_by :address
	reverse_geocoded_by :latitude, :longitude do |obj,results|
	  if geo = results.first
	  	obj.state 	=geo.state
	    obj.city    = geo.city
	    obj.postal_code = geo.postal_code
	    obj.country = geo.country
	  end
	end
	after_validation :reverse_geocode, :geocode, :if => :address_changed?
end
