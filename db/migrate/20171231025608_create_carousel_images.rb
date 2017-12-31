class CarouselImages < ActiveRecord::Migration[5.1]
  def change
    create_table :carousel_images do |t|
      t.string :image_url
      t.text :description
      t.boolean :visible
    end
  end
end
