class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :about, :twitter, :image

  has_many :memberships
  has_many :clubs, through: :memberships
end
