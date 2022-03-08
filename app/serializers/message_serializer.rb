class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :category

  belongs_to :user
end
