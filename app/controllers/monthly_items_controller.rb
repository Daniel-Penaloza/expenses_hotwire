class MonthlyItemsController < ApplicationController
  before_action :set_monthly_item, only: %i[show destroy]

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

  def show; end

  def destroy
    @monthly_item.destroy!

    respond_to do |format|
      format.html { redirect_to quotes_path, notice: "Monthly Item was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def set_monthly_item
    @monthly_item = MonthlyItem.find(params[:id])
  end

  def monthly_item_params
    params.require(:monthly_item).permit(:id, :month, items_attributes: [:item_id])
  end
end


