class CreateSections < ActiveRecord::Migration[5.0]
  def change
    create_table :sections do |t|
      t.string :name
      t.text :description
      t.integer :heading_id

      t.timestamps
    end
  end
end
