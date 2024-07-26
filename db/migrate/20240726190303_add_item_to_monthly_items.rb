class AddItemToMonthlyItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :monthly_item, null: false, foreign_key: true
  end
end
