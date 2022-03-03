class ClubsController < ApplicationController
  before_action :authenticate_user, only: [:create, :update]

  def index
    clubs = Club.all
    render json: clubs
  end

  def create
    #Convert search terms into correct format for Random House API
    title_search = (params[:title]).gsub!(" ","+")
    
    #Search for title from params
    api = Rails.application.credentials.rh_api
    response = HTTP.get("https://api.penguinrandomhouse.com/resources/v2/title/domains/PRH.US/search?q=#{title_search}&api_key=#{api}")
    work_id = response.parse(:json)["data"]["results"][1]["key"]
    render json: work_id

    #Use work_id to confirm if book has discussion guide

    # response = HTTP.get("https://api.penguinrandomhouse.com/resources/v2/title/domains/PRH.US/works/#{work_id}/titles?showReadingGuides=true&api_key=#{api}")
    # # isbn = response.parse(:json)["data"]["titles"][0]["isbn"]

    # render json: response 

    # if isbn
    #   club = Club.new(
    #     name: params[:name],
    #     isbn: isbn,
    #     work_id: work_id,
    #     is_active: true
    #   )
    #   if club.save
    #     membership = Membership.create(
    #       user_id: current_user.id, 
    #       club_id: club.id
    #     )
    #     render json: club
    #   else
    #     render json: {errors: club.errors.full_messages}, status: :unprocessable_entity 
    #   end
    # else
    #   render json: {message: "Pick a new book."}
    # end
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
