class AddImage < ActiveRecord::Migration[5.1]
  def change
  	add_column :sections, :imageURL, :string
  end
end
