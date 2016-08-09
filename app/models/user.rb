class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :confirmable, :rememberable, :trackable, :validatable
	has_many :lisitngs
  has_many :favorite_listings
  has_many :raters, through: :reviews, class_name: "User", foreign_key: :user_id # The users this user has rated
  has_many :users, through: :reviews, class_name: "User", foreign_key: :reter_id
  has_many :user_credits
  has_attached_file :image,
    :styles => {
      :thumb => "50x50#",
      :medium => "200x200#"
  }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/x
	def has_payment_info?
	  braintree_customer_id
	end

  def favorite_listing? listing
    return true unless self.favorite_listings.where(listing_id: listing).empty?
    return false
  end

  def code_generate
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    self.code = (0...8).map { o[rand(o.length)] }.join
  end

  protected
  def confirmation_required?
    false
  end
end
