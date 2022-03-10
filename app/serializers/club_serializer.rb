class ClubSerializer < ActiveModel::Serializer
  attributes :id, :name, :work_id, :isbn, :is_active

  attribute :is_member?, if: :current_user

  belongs_to :book
  belongs_to :details
  has_many :messages, if: :current_user
  has_many :memberships

  def is_member?
    Membership.exists?(user_id: current_user.id, club_id: object.id)
  end


end
