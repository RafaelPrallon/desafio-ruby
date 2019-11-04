class ProductsController < ApplicationController

  protect_from_forgery prepend: true
  before_action :authenticate_store!, only: [:edit, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @stores = Store.all
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
			flash[:notice] = "O produto foi atualizado com sucesso."
			redirect_to product_path(@product)
		else
			render :edit
    end
  end

  def delete
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :image_url, :price, :installments, :url)
    end
end
