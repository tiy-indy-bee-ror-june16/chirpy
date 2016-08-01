class AuthenticationController < ApplicationController

  def create
    if params[:username] && @user = User.find_for_auth(params[:username])
      if @user.authenticate(params[:password])
        render json: @user, serializer: UserExpandedSerializer
      else
        render json: {error: "Password does not match"}, status: 400
      end
    else
      render json: {error: "User does not exist"}, status: 400
    end
  end

end
