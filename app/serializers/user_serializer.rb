class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :about, :twitter, :image

  has_many :clubs
end
