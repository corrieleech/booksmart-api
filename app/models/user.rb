class User < ApplicationRecord
  has_many :memberships
  has_many :clubs, through: :memberships
  has_many :messages

end
