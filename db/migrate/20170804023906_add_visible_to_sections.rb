class AddVisibleToSections < ActiveRecord::Migration[5.1]
  def change
    add_column :sections, :visible, :boolean
  end
end
