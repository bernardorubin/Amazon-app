class ProductsController < ApplicationController
  before_action(:find_product, { only: [:show, :edit, :destroy, :update] })

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:notice] = 'Product created successfully'
      redirect_to product_path (@product)
    else
      flash.now[:alert] = 'Please fix errors below'
      render :new
    end
  end



  def show
    @review = Review.new
    @category = Category.find @product.category
    # @product = Product.find params[:id]
  end


  def index
  if params[:category]
    @products = Product.order(created_at: :desc).where("category = '#{params[:category]}'")

  else
    @products = Product.order(created_at: :desc)
  end
  end

  def edit
    # @product = Product.find params[:id]
  end

  def update
    if @product.update product_params
      redirect_to product_path(@product), notice: 'Product updated!'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: 'Product deleted!'
  end


  private

  def product_params
    params.require(:product).permit([:title, :description, :price, :category])
  end

  def find_product
    @product = Product.find params[:id]
  end


end
