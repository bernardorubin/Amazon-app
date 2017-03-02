class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_like, only: :destroy
  before_action :find_product, only: :create

# MAX-DEREK'S COMPLEX CODE ///////////////////////////////////////
  # after_action :store_location
  # def store_location
  #   # store last url as long as it isn't a /users path
  #   session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/ || request.fullpath =~ /\/sessions/ || request.fullpath =~ /\/password/
  # end
  #
  # def after_sign_in_path
  #   session[:previous_url] || root_path
  # end
# /////////////////////////////////////////////////////////

  def create
    like = Like.new(user: current_user, product: @product)
    if cannot? :like, @product
      redirect_back fallback_location: products_path, alert: 'Liking your own product is frowned upon'
      return
    end
    if like.save
      redirect_back fallback_location: products_path, notice: 'Product liked! 👍'
    else
      redirect_back fallback_location: products_path, alert: 'Couldn\'t like product 🤙'
    end
  end

  def destroy
    if can? :like, @like.product
        opts = nil
        @like.destroy ? opts = {notice: 'Product Un-liked 👎'} : opts = {alert: @like.errors.full_messages.join(', ')}
        redirect_back fallback_location: products_path, **opts
    else
      redirect_back fallback_location: products_path, alert: 'Un-Liking your own product isn\'t allowed'
    end
  end

  private

  def find_like
    @like ||= Like.find(params[:id])
  end

  def find_product
    @product ||= Product.find(params[:product_id])
  end
end
