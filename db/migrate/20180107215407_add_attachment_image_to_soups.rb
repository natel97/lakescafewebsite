class AddAttachmentImageToSoups < ActiveRecord::Migration[5.1]
  def self.up
    change_table :soups do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :soups, :image
  end
end
