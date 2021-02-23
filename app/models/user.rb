class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :username, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }, allow_nil: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable,
         :lockable, :timeoutable, :trackable
  enum sex: { man: 0, woman: 1}
end
