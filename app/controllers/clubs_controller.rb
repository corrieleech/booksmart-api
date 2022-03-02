class ClubsController < ApplicationController
  def index
    clubs = Club.all
    render json: clubs
  end

  def create
    club = Club.new(
      name: params[:name],
      isbn: params[:isbn],
      work_id: params[:work_id],
      is_active: true
    )
    if club.save
      render json: club
    end
  end

  def show
    club = Club.find(params[:id])
    render json: club
  end

  def update
    club = Club.find(params[:id])
    club.name = params[:name] || club.name
    club.is_active = params[:is_active]
    if club.save
      render json: club
    else
      render json: {errors: club.errors.full_messages}, status: :unprocessable_entity 
    end
  end

end
