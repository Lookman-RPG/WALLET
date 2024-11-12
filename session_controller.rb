class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { message: "Berhasil login" }
    else
      render json: { error: "Kredensial tidak valid" }, status: :unauthorized
    end
  end

  def destroy
    session.delete(:user_id)
    render json: { message: "Berhasil logout" }
  end
end
