class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :category

  belongs_to :user
  belongs_to :club
  
end
