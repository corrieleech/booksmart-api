class Message < ApplicationRecord
  belongs_to :user
  belongs_to :club

  validates :body, length: { minimum: 2 }
end
