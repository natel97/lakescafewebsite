class CreateSoups < ActiveRecord::Migration[5.1]
  def change
    create_table :soups do |t|
      t.string :name
      t.string :image_url
      t.boolean :is_today

      t.timestamps
    end
  end
end
