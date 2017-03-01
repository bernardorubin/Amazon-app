class ReviewsController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index]
    before_action :authorize, only: [:destroy]

  def create
    review_params    = params.require(:review).permit(:body, :rating)
    @review          = Review.new review_params
    @product         = Product.find params[:product_id]
    @review.product   = @product
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product), notice: 'review created!'
    else
      logger.debug "Review failed Validations".yellow
      logger.debug " - #{@review.errors.full_messages.join("\n - ")} The Review was not saved".yellow
      flash[:alert] = 'please fix errors'
      render 'products/show'
    end
  end

  def destroy
    review = Review.find params[:id]
    review.destroy
    redirect_to product_path(review.product_id), notice: 'Review deleted!'
  end


  private

  def authorize

    if cannot?(:manage, @review)
      review = Review.find params[:id]
      redirect_to product_path(review.product_id), alert: 'Not authorized!'
    end
  end

end
