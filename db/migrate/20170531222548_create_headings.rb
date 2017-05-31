class CreateHeadings < ActiveRecord::Migration[5.0]
  def change
    create_table :headings do |t|
      t.string :name

      t.timestamps
    end
  end
end
