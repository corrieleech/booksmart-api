class ClubSerializer < ActiveModel::Serializer
  attributes :id, :name, :work_id, :isbn, :is_active, :book
  
  attribute :is_member?, if: :current_user
  attribute :messages, if: :current_user
  attribute :memberships, if: :current_user

  def is_member?
    Membership.exists?(user_id: current_user.id, club_id: object.id)
  end

end

