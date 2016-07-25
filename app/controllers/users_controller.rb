class UsersController < ApplicationController

  before_action :require_user, only: [:show, :index]

  def index
    @users = User.where.not(id: current_user.id)
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserRegistrationMailer.welcome_email(@user).deliver_later
      render json: @user, serializer: UserExpandedSerializer
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
    if params[:id] == 'me'
      @user = current_user
      render json: @user, serializer: UserExpandedSerializer
    else
      @user = User.find(params[:id])
      render json: @user, scope: current_user, scope_name: :current_user
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password, :bio, :avatar)
  end

end
