class SessionsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by_email params[:email]
    if user&.authenticate(params[:password])
      session[:user_id] = user.id

      user_ip = request.remote_ip
      # Location.create(ip_address: user_ip, user: user)
      Location.create(ip_address: "50.64.108.159", user: user)

      redirect_to root_path, notice: 'Signed In!'
    else
      flash.now[:alert] = 'Wrong Credentials'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Signed out!'
  end

end
