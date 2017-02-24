class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def user_signed_in?
    session[:user_id].present?
  end

  def current_user
    @current_user ||= User.find session[:user_id]
  end

  def authenticate_user!
    unless user_signed_in?
      redirect_to new_session_path, notice: 'Please sign in'
    end
  end

  helper_method :user_signed_in?
  helper_method :current_user
end
