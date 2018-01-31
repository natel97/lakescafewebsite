class CreateSpecials < ActiveRecord::Migration[5.1]
  def change
    create_table :specials do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.boolean :breakfast

      t.timestamps
    end
  end
end
