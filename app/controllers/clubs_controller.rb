class ClubsController < ApplicationController
  before_action :authenticate_user, only: [:create, :update]

  def index
    clubs = Club.where(is_active: true)
    render json: clubs, fields: [:id, :name, :work_id, :isbn, :is_active, :book]
  end

  def create
    club = Club.new(
      name: params[:name],
      isbn: params[:isbn],
      is_active: true
    )
    if club.save
      membership = Membership.create(
        user_id: current_user.id, 
        club_id: club.id
      )
      render json: club, include: []
    else
      render json: {errors: club.errors.full_messages}, status: :unprocessable_entity 
    end
  end

  def show
    club = Club.find(params[:id])
    render json: club, include: ["memberships.user"]
  end

  def update
    club = Club.find(params[:id])
    if club.users.include?(current_user)
      club.name = params[:name] || club.name
      club.is_active = params[:is_active]
      if club.save
        render json: club
      else
        render json: {errors: club.errors.full_messages}, status: :unprocessable_entity 
      end
    else
      render json: {}, status: :unauthorized
    end
  end

end
