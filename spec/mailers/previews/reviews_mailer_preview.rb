# Preview all emails at http://localhost:3000/rails/mailers/reviews_mailer
class ReviewsMailerPreview < ActionMailer::Preview
  def notify_product_owner(review)
   @review    = review
   @product   = review.product
   @owner     = @product.user
   if @owner.present?
     mail(to: @owner.email, subject: 'You got a new review to your product')
   end
 end
end
