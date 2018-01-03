class AddImageCaptionToSection < ActiveRecord::Migration[5.1]
  def change
      add_column :sections, :image_caption, :string
  end
end
