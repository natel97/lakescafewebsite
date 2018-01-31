class AddTodayToSpecial < ActiveRecord::Migration[5.1]
  def change
    add_column :specials, :today, :boolean
    remove_column :sections, :imageURL
    remove_column :soups, :image_url
    remove_column :carousel_images, :image_url
  end
end
