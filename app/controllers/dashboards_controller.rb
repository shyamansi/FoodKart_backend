
class DashboardsController < ApplicationController
  include Rails.application.routes.url_helpers
  #before_action :authenticate_user!
  before_action :set_product, only: [:update, :destroy, :edit]

  def summary
    #authorize Product, :summary?, policy_class: ProductPolicy
    products = Product.order(id: :desc)
    products_with_images = products.map do |product|
      product.as_json(only: [:id, :name, :price, :category_name]).merge(
        image_url: product.image.attached? ? url_for(product.image) : nil
      )
    end
    render json: products_with_images
  end

  def create
    #authorize Product, :create?, policy_class: ProductPolicy
    product = Product.new(product_params)
    product.user = current_user if product.respond_to?(:user=)
    if product.save
      render json: product.as_json.merge(image_url: product.image.attached? ? url_for(product.image) : nil), status: :ok
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def edit
    #authorize @product, :edit?, policy_class: ProductPolicy
    if @product
      render json: @product.as_json.merge(image_url: @product.image.attached? ? url_for(@product.image) : nil), status: :ok
    else
      render json: { error: 'Product not found' }, status: :not_found
    end
  end

  def update
   # authorize @product, :update?, policy_class: ProductPolicy
    if @product.update(product_params)
      render json: @product.as_json.merge(image_url: @product.image.attached? ? url_for(@product.image) : nil), status: :ok
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    #authorize @product, :destroy?, policy_class: ProductPolicy if @product
    if @product
      @product.destroy
      render json: { message: 'Product deleted successfully' }, status: :ok
    else
      render json: { error: 'Product not found' }, status: :not_found
    end
  end

  private

  def set_product
    @product = Product.find_by(id: params[:id])
    render json: { error: 'Product not found' }, status: :not_found unless @product
  end

  def product_params
    params.require(:product).permit(:name, :price, :category_name, :image)
  end
end
 