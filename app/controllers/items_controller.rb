class ItemsController < ApplicationController
  before_action :set_quote, only: %i[show destroy]

  def index
    @items = Item.desc_order
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      respond_to do |format|
        format.html { redirect_to items_path, notice: 'Item was succesfully created' }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def destroy
    @item.destroy!

    respond_to do |format|
      format.html { redirect_to items_path, notice: "Quote was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :amount, :item_type)
  end

  def set_quote
    @item = Item.find(params[:id])
  end
end
