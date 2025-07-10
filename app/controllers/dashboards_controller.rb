class DashboardsController < ApplicationController
  def summary
  product = Product.order(id: :desc).select(:id, :name, :price, :category_name)
  render json: product
  end

  def create
    Rails.logger.info("Params: #{params.to_unsafe_h}")
   product = Product.new(product_params)
   Rails.logger.debug"shyam #{product_params.inspect}"
   if product.save
     Rails.logger.debug"shyam1111 #{product.inspect}"
    render json: product ,status: :ok
   else
    render json: {errors: product.errors.full_messages},status: :unprocessable_entity 
  end
  end
 def update
  product = Product.find(params[:id])
  if product
    if product&.update(product_params)
      render json: product ,status: :ok
    else
      render json: {errors: product.errors.full_messages},status: :unprocessable_entity
    end
  
  else
      render json: {error: "product not found"},status: :not_found
  end
 end
  private
  def product_params
    Rails.logger.debug("RAW PARAMS => #{params.inspect}")

   params.require(:product).permit(:name , :price ,:category_name)
  end
end
 