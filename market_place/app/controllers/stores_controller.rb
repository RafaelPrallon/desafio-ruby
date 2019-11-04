class StoresController < ApplicationController
  protect_from_forgery prepend: true
  before_action :authenticate_store!
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  def show
  end

  def edit
  end

  def update
    if @store.update(store_params)
			flash[:notice] = "A loja foi atualizada com sucesso."
			redirect_to store_path(@store)
		else
			render :edit
    end
  end

  def destroy
    @store.delete
    flash[:danger] = "A loja foi atualizada com sucesso"
    redirect_to root_path
  end

  private
    def set_store
      @store = Store.find(params[:id])
    end

    def store_params
      params.require(:store).permit(:name, :website, :email)
    end
  
end
