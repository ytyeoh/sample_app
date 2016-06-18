class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :lisitngs
  has_many :raters, through: :reviews, class_name: "User", foreign_key: :user_id # The users this user has rated
  has_many :users, through: :reviews, class_name: "User", foreign_key: :reter_id
  has_many :user_credits
  has_attached_file :image
  validates_attachment :image,
                     content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
	def has_payment_info?
	  braintree_customer_id
	end

  def code_generate
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    self.code = (0...8).map { o[rand(o.length)] }.join
  end

end
