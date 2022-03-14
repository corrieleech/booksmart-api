class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show, :update, :destroy]
  
  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      image: "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"
    )
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end
  
  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    user = User.find(params[:id])
    if current_user == user 
      user.name = params[:name]|| current_user.name
      user.email = params[:email] || current_user.email
      user.image = params[:image] || current_user.image
      user.location = params[:location] || current_user.location
      user.about = params[:about] || current_user.about
      user.twitter = params[:twitter] || current_user.twitter
      if user.save
        render json: user, include: [], status: :ok
      else
        render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
      end
    else 
      render json: {}, status: :unauthorized
    end
  end

  def destroy
    user = User.find(params[:id])
    if current_user == user
      user.destroy
      render json: {message: "User has been removed from the database."}
    else
      render json: {}, status: :unauthorized
    end
  end
  
end
