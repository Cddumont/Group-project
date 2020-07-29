class User < ApplicationRecord
  mount_uploader :profile_photo, ProfilePhotoUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :username, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  has_many :upvotes
  has_many :downvotes
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
