class MessagesController < ApplicationController
  before_action :authenticate_user

  def create
    message = Message.new(
      user_id: current_user.id,
      club_id: params[:club_id],
      body: params[:body],
      category: params[:category]
    )
    if message.save
      render json: message
    else
      render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    message = Message.find(params[:id])
    if message.user == current_user
      message.body = params[:body] || message.body
      message.category = params[:category] || message.category
      if message.save
        render json: message
      else
        render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: {}, status: :unauthorized
    end
  end

  def destroy
    message = Message.find(params[:id])
    if message.user == current_user
      message.destroy
      render json: {message: "Comment has been deleted."}
    else
    render json: {}, status: :unauthorized
    end
  end

end
