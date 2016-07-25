class ApplicationController < ActionController::API

  private

  def current_user
    if params[:auth_token] && User.exists?(auth_token: params[:auth_token])
      @current_user ||= User.find_by(auth_token: params[:auth_token])
    end
    @current_user
  end

  def require_user
    render json: {error: "You need to be logged in to do that"}, status: :forbidden unless current_user
  end

  def forbid_user
    render json: {error: "You're already logged in"}, status: :forbidden if current_user
  end

end
