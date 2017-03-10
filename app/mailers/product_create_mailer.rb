class ProductCreateMailer < ApplicationMailer
  def notify_product_created(product)
   @product = product
   @owner    = @product.user
   if @owner.present?
     mail(to: @owner.email, subject: 'You created a new product')
   end
 end
end
