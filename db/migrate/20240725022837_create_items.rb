class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.decimal :amount,  precision: 10, scale: 2, null: false
      t.string :item_type, null: false, default: ''

      t.timestamps
    end
  end
end
