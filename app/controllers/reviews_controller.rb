class ReviewsController < ApplicationController
  def create
    review_params    = params.require(:review).permit(:body, :rating)
    @review          = Review.new review_params
    @product = Product.find params[:product_id]
    @review.product = @product
    @review.save
    if @review.save
    redirect_to product_path(params[:product_id]), notice: 'review created!'
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
