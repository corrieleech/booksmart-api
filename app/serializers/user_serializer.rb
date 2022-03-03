class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :about, :twitter

  has_many :clubs, through: :memberships
end
