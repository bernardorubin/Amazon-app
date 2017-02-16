class Admin::DashboardController < Admin::BaseController

  def index
    @product_count = Product.count
    @review_count = Review.count
    @user_count = User.count
  end
end
