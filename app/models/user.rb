class User < ApplicationRecord
  before_validation { email.downcase! }
  mount_uploader :image, ImageUploader
  validates :image, presence: true
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  has_many :favorites,  dependent: :destroy
  has_many :favorite_pictures, through: :favorites, source: :picture
end
