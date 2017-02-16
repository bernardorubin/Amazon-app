class ReviewsController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index]

  def create
    review_params    = params.require(:review).permit(:body, :rating)
    @review          = Review.new review_params
    @product         = Product.find params[:product_id]
    @review.product   = @product
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product), notice: 'review created!'
    else
      flash[:alert] = 'please fix errors'
      render 'products/show'
    end
  end




  def destroy
    review = Review.find params[:id]
    review.destroy
    redirect_to product_path(review.product_id), notice: 'Review deleted!'
  end
end
