class CreateMontlyItems < ActiveRecord::Migration[7.1]
  def change
    create_table :monthly_items do |t|
      t.string :month, null: false, default: ''

      t.timestamps
    end
  end
end
