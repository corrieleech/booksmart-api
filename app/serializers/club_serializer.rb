class ClubSerializer < ActiveModel::Serializer
  attributes :id, :name, :work_id, :isbn, :is_active, :book

  has_many :users, through: :memberships
  has_many :messages
end
