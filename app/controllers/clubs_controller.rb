class ClubsController < ApplicationController
  before_action :authenticate_user, only: [:create, :update]

  def index
    clubs = Club.all
    render json: clubs
  end

  def create
    #Use work_id from book index selection to confirm if book has discussion guide
    api = Rails.application.credentials.rh_api
    response = HTTP.get("https://api.penguinrandomhouse.com/resources/v2/title/domains/PRH.US/works/#{params[:work_id]}/titles?showReadingGuides=true&api_key=#{api}")
    # isbn = response.parse(:json)["data"]["titles"][0]["isbn"]

    if response.parse(:json)["code"] == 404
      render json: {message: "Book currently does not have a corresponding discussion guide to populate discussion forum. Please choose another book."}
    else
      isbn = response.parse(:json)["data"]["titles"][0]["isbn"]
      club = Club.new(
        name: params[:name],
        isbn: isbn,
        work_id: params[:work_id],
        is_active: true
      )
      if club.save
        membership = Membership.create(
          user_id: current_user.id, 
          club_id: club.id
        )
        render json: club
      else
        render json: {errors: club.errors.full_messages}, status: :unprocessable_entity 
      end
    end
  end

  def show
    club = Club.find(params[:id])
    render json: club
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
