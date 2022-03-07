class MembershipSerializer < ActiveModel::Serializer
  attributes :id, :club_id

  belongs_to :user
end
