class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :lisitngs
  has_many :raters, through: :reviews, class_name: "User", foreign_key: :user_id # The users this user has rated
  has_many :users, through: :reviews, class_name: "User", foreign_key: :reter_id

end
