class Api::BaseController < ApplicationController
  # this will not throw an exception if an authenticity token is not passed
  # however, it will just clear the sessions by deleting all the cookies that
  # came as part of the request. In many cases of using APIs we don't use
  # cookies so it's ok for us to have no cookeis and consquently empty session
  # it will go through and clear cookie
  # if you don't have a cookie you are not signed in
  protect_from_forgery with: :null_session
  before_action :authenticate

  private

  def authenticate
    # through headers
    # Rails.logger.info ">>>>>>>>>>>>>>"
    # Rails.logger.info request.headers["HTTP_API_KEY"]
    # Rails.logger.info ">>>>>>>>>>>>>>"
    @user = User.find_by_api_key params[:api_key]
    # returns 401 if anauthorized
    head :unauthorized unless @user.present?
  end

end
