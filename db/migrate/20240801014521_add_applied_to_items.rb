class AddAppliedToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :applied, :boolean
  end
end
