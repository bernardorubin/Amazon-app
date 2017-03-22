class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = current_user

    # @user = User.find session[:user_id]
    @users = User.all
    @user_count = User.count
    
    # @location = @user.locations.last
  end

  def create
    user_params = params.require(:user).permit(:first_name,
                                                :last_name,
                                                :email,
                                                :address,
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
