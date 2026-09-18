class SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
  end

  def create
    user = User.find_by(username: params.dig(:session, :username))
    if user&.authenticate(params.dig(:session, :password))
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:alert] = "Usuario o contraseña incorrectos"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end