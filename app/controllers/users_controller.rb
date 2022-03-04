class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show, :update, :destroy]
  
  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if user.save
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end
  
  def show
    user = User.find(params[:id])
    if current_user == user 
      render json: user
    else
      render json: {message: [], status: :bad_request}
    end
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
        render json: {message: "#{user.name}'s profile has been updated.", profile: user}, status: :ok
      else
        render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
      end
    else 
      render json: {errors: user.errors.full_messages}, status: :unauthorized
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
