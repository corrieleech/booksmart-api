class MembershipsController < ApplicationController
  before_action :authenticate_user

  def create
    membership = Membership.new(
      user_id: current_user.id,
      club_id: params[:club_id]
    )
    if membership.save
      render json: membership
    else
      render json: {errors: membership.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    membership = Membership.find(params[:id])
    if membership.user == current_user
      membership.destroy
      render json: {message: "Membership has been deleted."}
    else
      render json: {}, status: :unauthorized
    end
  end

end
