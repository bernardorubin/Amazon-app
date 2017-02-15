class WelcomeController < ApplicationController
  def index
    @categories = Category.all
  end

  def contact
  end

  def about
  end

  def contact_submit
    @name = params[:name]
  end
end
