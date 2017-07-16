class FixPaperclipMishap < ActiveRecord::Migration[5.1]
  def change
  	  	add_column :sections, :imageURL, :string
  	  	remove_column :sections, :image_file_name
  	  	remove_column :sections, :image_content_type
  	  	remove_column :sections, :image_file_size
  	  	remove_column :sections, :image_updated_at
  end
end
