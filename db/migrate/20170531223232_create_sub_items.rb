class CreateSubItems < ActiveRecord::Migration[5.0]
  def change
    create_table :sub_items do |t|
      t.string :name
      t.text :description
      t.float :price
      t.integer :item_id

      t.timestamps
    end
  end
end
