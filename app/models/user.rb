class User < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :clubs, through: :memberships
  has_many :messages, dependent: :destroy

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
