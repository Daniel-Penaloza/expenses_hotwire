class ItemsController < ApplicationController
  before_action :set_item, only: %i[show destroy]
  before_action :set_monthly_item, only: %i[new create destroy update]

  def index
    @items = Item.desc_order
  end

  def new
    @item = @monthly_item.items.build
  end

  def create
    @item = @monthly_item.items.build(item_params)

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

  def update
    @item = @monthly_item.items.find(params[:id])

    if @item.update(item_params)
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @item.destroy!

    respond_to do |format|
      format.html { redirect_to items_path, notice: "Item was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :amount, :item_type, :applied, monthly_items_attributes: [:monthly_item_id])
  end

  def set_item
    debugger
    @item = Item.find(params[:id])
  end

  def set_monthly_item
    @monthly_item = MonthlyItem.find(params[:monthly_item_id])
  end
end
