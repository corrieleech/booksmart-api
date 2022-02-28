class User < ApplicationRecord
  has_many :memberships
  has_many :clubs, through: :memberships
  has_many :messages

  has_secure_password
  validates :email, presence: true, uniqueness: true
end
