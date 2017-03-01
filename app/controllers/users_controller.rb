class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:first_name,
                                                :last_name,
                                                :email,
                                                :password,
                                                :password_confirmation)
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Account created successfully!'
    else
      logger.debug "Users failed Validations".yellow
      logger.debug " - #{@user.errors.full_messages.join("\n - ")} The User was not saved".yellow
      render :new
    end
  end
end
