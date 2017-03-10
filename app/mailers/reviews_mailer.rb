class ReviewsMailer < ApplicationMailer
  def notify_product_owner(review)
   @review   = review
   @product = review.product
   @owner    = @product.user
   @reviewer = @review.user
   if @owner.present?
     mail(to: @owner.email, subject: 'You got a new review to your product')
   end
 end
end
