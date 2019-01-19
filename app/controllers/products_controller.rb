class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  
  # GET /products
  def index
    if params[:onlyinstock] == "1"
      @products = Product.where("inventory_count > 0")
    else
      @products = Product.all
    end
    json_response(@products)
  end

  # GET /products/:id
  def show
    json_response(@product)
  end
  
  # POST /products/:id/purchase
  def purchase
    @purchase_prod = Product.where("id = " + params[:id]).first
    if @purchase_prod.inventory_count > 0
      @purchase_prod.inventory_count -= 1
      @purchase_prod.save
    end
    json_response(@purchase_prod)
  end

  # Helpers
  private
  
  def product_params
    # whitelist params
    params.permit(:title, :price, :inventory_count)
  end
  
  def set_product
    @product = Product.find(params[:id])
  end
end
