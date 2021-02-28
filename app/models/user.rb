class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :username, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }, on: :create
  validates :password, allow_blank: true, confirmation: true, length: { minimum: 6 }, on: :update
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable,
         :timeoutable, :trackable
  enum sex: { man: 0, woman: 1}
  validates :profile, length: { maximum: 255 }
end
