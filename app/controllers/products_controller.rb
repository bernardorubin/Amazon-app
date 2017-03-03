class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action(:find_product, { only: [:show, :edit, :destroy, :update] })
  before_action :authorize, only: [:edit, :destroy, :update]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      flash[:notice] = 'Product created successfully'
      redirect_to product_path (@product)
    else
      logger.debug "Product failed Validations".yellow
      logger.debug " - #{@product.errors.full_messages.join("\n - ")} The Product was not saved".yellow
      flash.now[:alert] = 'Please fix errors below'
      render :new
    end

  end

  def show
    @review = Review.new
    @category = Category.find @product.category
    @product = Product.find params[:id]
    @username = User.find @product.user_id
    # new
    @tags = Tag.find @product.tag_ids
  end


  def index
    # render json:params
    if params[:tag_id]
       @tagging = Tagging.where(tag_id: params[:tag_id])
       @products_array = []
       @tagging.each do |x|
         @products_array << (x.product_id)
       end
       @products = Product.order(created_at: :desc).find(@products_array)
     else
       @products = Product.order(created_at: :desc)
     end

     #  if params[:category]
     #    @products = Product.order(created_at: :desc).where("tag = '#{params[:tag]}'")
     #  else
     #    @products = Product.order(created_at: :desc)
     #  end

     # TA CODE DIDN'T WORK
      #  @products = Product.all
      #  if params[:product_tag].present?
      #    render json:params
      #    @products = Product.all.product_tag(params[:product_tag])
      #  end
      #
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
    params.require(:product).permit([:title, :description, :price, :category, {tag_ids: []}, :tag_id])
  end

  def find_product
    @product = Product.find params[:id]
  end

  def authorize
    if cannot?(:manage, @product)
      redirect_to root_path, alert: 'Not authorized!'
    end

  end

  # def rev_authorize
  #   if cannot?(:manage, @review)
  #     redirect_to root_path, alert: 'Not authorized!'
  #   end
  # end




end
