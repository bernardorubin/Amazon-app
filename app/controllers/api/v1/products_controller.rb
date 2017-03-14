class Api::V1::ProductsController < ApplicationController

  PER_PAGE = 10

  def index
    current_page = params.fetch(:page, 0).to_i
    offset = PER_PAGE * current_page
    @products = Product.order(created_at: :desc).limit(PER_PAGE).offset(offset)
    @more_products = (Product.count - ((current_page + 1) * PER_PAGE)) > 0
  end

  def show
    product = Product.find params[:id]
    render json: product
  end

  def create
    product_params = params.require(:product).permit(:title, :description)
    product = Product.new product_params
    product.user = @user
    if product.save
      render json: {success: true, id: product.id}
    else
      render json: {success: false, errors: product.errors.full_messages }
    end
  end

  # def update
  #   if @product.update product_params
  #     redirect_to product_path(@product), notice: 'Product updated!'
  #   else
  #     render :edit
  #   end
  # end
  #
  # def destroy
  #   @product.destroy
  #   redirect_to products_path, notice: 'Product deleted!'
  # end
end
