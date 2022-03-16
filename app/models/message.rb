class Message < ApplicationRecord
  belongs_to :user
  belongs_to :club

  validates :body, presence: true
end
