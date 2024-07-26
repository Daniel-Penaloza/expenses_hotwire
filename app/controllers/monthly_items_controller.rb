class MonthlyItemsController < ApplicationController
  def index
    @monthly_items = MonthlyItem.all
  end

  def new
    @monthly_item = MonthlyItem.new
  end

  def create
    @monthly_item = MonthlyItem.new(monthly_item_params)

    if @monthly_item.save
      respond_to do |format|
        format.html { redirect_to items_path, notice: 'Monthly Item was succesfully created' }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @monthly_item = MonthlyItem.find(params[:id])
  end

  private

  def monthly_item_params
    params.require(:monthly_item).permit(:month, items_attributes: [:item_id])
  end
end


